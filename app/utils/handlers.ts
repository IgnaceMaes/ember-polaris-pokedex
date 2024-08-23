import type { Handler, NextFn, RequestContext } from '@ember-data/request';

export const JsonSuffixHandler: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;

    if (request.url?.endsWith('.json')) {
      return next(request);
    }

    const updatedRequest = Object.assign({}, request, {
      url: request.url + '.json',
    });

    return next(updatedRequest);
  },
};
