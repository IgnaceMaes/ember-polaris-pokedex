import { createDeferred } from '@ember-data/request';
import type { Deferred } from '@ember-data/request/-private/types';

export type SuccessResponseEventData = {
  type: 'success-response';
  thread: string;
  url: string;
};
export type ErrorResponseEventData = {
  type: 'error-response';
  thread: string;
  url: string;
};

export type RequestEventData = {
  type: 'load';
  thread: string;
  url: string;
};

export type ThreadInitEventData = {
  type: 'connect';
  thread: string;
};

export type MainThreadEvent = MessageEvent<
  SuccessResponseEventData | ErrorResponseEventData
>;
export type WorkerThreadEvent =
  | MessageEvent<RequestEventData>
  | MessageEvent<ThreadInitEventData>;

import { assert } from '@ember/debug';

export interface FastBoot {
  // eslint-disable-next-line no-unused-vars
  require(_moduleName: string): unknown;
  isFastBoot: boolean;
  request: Request;
}

const isServerEnv = typeof FastBoot !== 'undefined';

// This is a copy of WarpDrive's ImageFetch class with
// a temporary fix for an issue with which url is returned.
export class ImageFetch {
  declare worker: Worker | SharedWorker;
  declare threadId: string;
  declare pending: Map<string, Deferred<string>>;
  declare channel: MessageChannel;
  declare cache: Map<string, string>;
  declare queue: MainThreadEvent[];

  constructor(worker: Worker | SharedWorker | null) {
    this.threadId = isServerEnv ? '' : crypto.randomUUID();
    this.pending = new Map();
    this.cache = new Map();
    this.queue = [];

    const isTesting = false;
    assert(
      `Expected a SharedWorker instance`,
      isTesting || isServerEnv || worker instanceof SharedWorker,
    );
    this.worker = worker as SharedWorker;

    if (!isServerEnv) {
      const fn = (event: MainThreadEvent) => {
        this.queue.push(event);
        if (this.queue.length === 1) {
          setTimeout(() => {
            this.processQueue();
          }, 0);
        }
      };

      if (worker instanceof SharedWorker) {
        worker.port.postMessage({ type: 'connect', thread: this.threadId });
        worker.port.onmessage = fn;
      } else if (worker) {
        this.channel = new MessageChannel();
        worker.postMessage({ type: 'connect', thread: this.threadId }, [
          this.channel.port2,
        ]);

        this.channel.port1.onmessage = fn;
      }
    }
  }

  processQueue() {
    const queue = this.queue;
    this.queue = [];

    queue.forEach((event) => {
      const { type, url, objectUrl } = event.data;
      const deferred = this.cleanupRequest(url);
      if (!deferred) {
        return;
      }

      if (type === 'success-response') {
        deferred.resolve(objectUrl);
        return;
      }

      if (type === 'error-response') {
        deferred.reject(null);
        return;
      }
    });
  }

  cleanupRequest(url: string) {
    const deferred = this.pending.get(url);
    this.pending.delete(url);

    return deferred;
  }

  _send(event: RequestEventData) {
    this.worker instanceof SharedWorker
      ? this.worker.port.postMessage(event)
      : this.channel.port1.postMessage(event);
  }

  load(url: string) {
    if (isServerEnv) {
      return Promise.resolve(url);
    }

    const objectUrl = this.cache.get(url);
    if (objectUrl) {
      return Promise.resolve(objectUrl);
    }

    const deferred = createDeferred<string>();
    this.pending.set(url, deferred);
    this._send({ type: 'load', thread: this.threadId, url });
    return deferred.promise;
  }
}

export default {
  create() {
    return new ImageFetch(
      new SharedWorker(
        new URL('../data-worker/image-worker.ts', import.meta.url),
        {
          name: 'ImageWorker',
          type: 'module',
        },
      ),
    );
  },
};
