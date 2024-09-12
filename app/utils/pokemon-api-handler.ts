import type { Handler, NextFn } from '@ember-data/request';
import type { StoreRequestContext } from '@ember-data/store';

export const PokemonHandler: Handler = {
  async request<T>(context: StoreRequestContext, next: NextFn<T>) {
    let { request } = context;

    if (request.url && !request.url.endsWith('.json')) {
      request = Object.assign({}, request, {
        url: request.url + '.json',
      });
    }

    return next(request);
  },
};
