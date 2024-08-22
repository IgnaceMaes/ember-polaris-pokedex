import type { Handler, NextFn, RequestContext } from '@ember-data/request';

type RawPokemon = {
  id?: number;
  [key: string]: unknown;
};

export const JsonSuffixHandler: Handler = {
  async request<T>(context: RequestContext, next: NextFn<T>) {
    const { request } = context;
    const updatedRequest = Object.assign({}, request, {
      url: request.url + '.json',
    });

    const result = await next(updatedRequest);
    return normalizeData<T>(result.content as { data: RawPokemon[] });
  },
};

function normalizeData<T>(content: { data: RawPokemon[] }): T {
  const data = [];

  for (const datum of content.data) {
    const resource = {
      id: String(datum.id),
      type: 'pokemon',
      attributes: datum,
    };
    delete datum.id;
    data.push(resource);
  }

  return {
    data,
  } as T;
}
