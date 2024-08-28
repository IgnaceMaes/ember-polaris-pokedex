import type { Handler, NextFn } from '@ember-data/request';
import type { StoreRequestContext } from '@ember-data/store';

export const PokemonHandler: Handler = {
  async request<T>(context: StoreRequestContext, next: NextFn<T>) {
    let { request } = context;

    if (request.url?.endsWith('.json')) {
      request = Object.assign({}, request, {
        url: request.url + '.json',
      });
    }

    // in the findRecord case, we can check the cache first
    // since our individual finds are always the same data as
    // we get from list endpoints.
    if (request.op === 'findRecord') {
      const { store } = context.request;
      const identifier = store.identifierCache.getOrCreateDocumentIdentifier(
        context.request,
      );
      const peeked = identifier ? store.cache.peekRequest(identifier) : null;

      if (!peeked) {
        const identifier = request.records?.[0];
        const record = identifier ? store.cache.peek(identifier) : null;

        if (record) {
          const headers = new Headers();
          headers.set('date', new Date().toUTCString());
          const response = new Response(null, {
            headers,
          });
          context.setResponse(response);

          return {
            data: record,
          } as T;
        }
      }
    }

    return next(request);
  },
};
