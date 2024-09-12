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

    // in the findRecord case, we can check the cache first
    // since our individual finds are always the same data as
    // we get from list endpoints.
    if (request.op === 'findRecord') {
      const { store } = context.request;
      const identifier = store.identifierCache.getOrCreateDocumentIdentifier(
        context.request,
      );
      const peeked = identifier ? store.cache.peekRequest(identifier) : null;

      // if we don't have a request yet, try peeking the identifier
      if (!peeked) {
        const identifier = request.records?.[0];
        const record = identifier ? store.cache.peek(identifier) : null;

        // if the cache has an entry, generate a fake response
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

    return next(request).then((response) => {
      fixLinkOrigin(response.content);
      return response;
    });
  },
};

function prefixOrigin(link: string | null | undefined) {
  if (link?.startsWith('/')) {
    return location.origin + link;
  }
  return link || null;
}

function hasLinks(
  content: unknown,
): content is { links: Record<string, string | null> } {
  return Boolean(
    content &&
      typeof content === 'object' &&
      'links' in content &&
      typeof content.links === 'object' &&
      content.links,
  );
}

function fixLinkOrigin(content: unknown) {
  if (hasLinks(content)) {
    Object.keys(content.links).forEach((key) => {
      content.links[key] = prefixOrigin(content.links[key]);
    });
  }
}
