import { WorkerFetch } from '@warp-drive/experiments/worker-fetch';

export const WorkerHandler = new WorkerFetch(
  new SharedWorker(new URL('./data-worker.ts', import.meta.url), {
    name: 'DataWorker',
    type: 'module',
  }),
);
