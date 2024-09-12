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
