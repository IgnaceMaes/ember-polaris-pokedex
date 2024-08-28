import PokemonGridItem from 'ember-polaris-pokedex/components/pokemon-grid-item';
import type IndexRoute from 'ember-polaris-pokedex/routes';
import { Request } from '@warp-drive/ember';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-polaris-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import LoadingBar from 'ember-polaris-pokedex/components/loading-bar';
// @ts-expect-error untyped
import didIntersect from 'ember-scroll-modifiers/modifiers/did-intersect';
import { cached } from '@glimmer/tracking';

import type { Document } from '@ember-data/store';
import { service } from '@ember/service';
import type Store from '@ember-data/store';
import type { Pokemon } from 'ember-polaris-pokedex/schemas/pokemon';
import { getRequestState } from '@warp-drive/ember';
import { TrackedObject } from 'tracked-built-ins';

type IndexTemplateSignature = RouteTemplateSignature<IndexRoute>;

class Pages<T> {
  // this is a hack to deal with a vite build issue where decorators on fields
  // seem to be unsupported
  cache: {
    pages: Document<T[]>[];
    data: T[];
  };

  get pages() {
    return this.cache.pages;
  }

  get data() {
    return this.cache.data;
  }

  constructor(page: Document<T[]>) {
    this.cache = new TrackedObject<{
      pages: Document<T[]>[];
      data: T[];
    }>({
      pages: [page],
      data: page.data!.slice(),
    });
  }

  addPage(page: Document<T[]>) {
    this.pages.push(page);
    this.cache.data = this.data.concat(page.data!);
  }
}

const observerOptions = {
  rootMargin: '750px',
  threshold: 0,
};

@RouteTemplate
export default class IndexTemplate extends Component<IndexTemplateSignature> {
  @service declare store: Store;

  @cached
  get pageCollection() {
    const state = getRequestState(this.args.model.pokemonRequest);
    if (state.isLoading || state.isError) {
      return null;
    }
    // @ts-expect-error this probably needs a generic on getRequestState to be tweaked
    return new Pages<Pokemon>(state.result!);
  }

  lastReached = async () => {
    if (!this.pageCollection) {
      return;
    }
    const page = this.pageCollection.pages.at(-1);

    // temporary hack since we don't have a real API and so can't make the origins on the links pre-set
    // usually you'd just call `page.next()` here
    const link = page!.links?.next;
    if (!link) {
      return;
    }
    const result = await this.store.request({
      url: window.location.origin + link,
      method: 'GET',
    });
    if (result) {
      // @ts-expect-error need to figure out how to juggle identity with / vs origin
      // normally content would be auto-typed from the initial request due to calling `next`
      this.pageCollection.addPage(result.content!);
    }
  };

  <template>
    <Request @request={{@model.pokemonRequest}}>
      <:content>
        <div
          class='grid grid-cols-2 gap-4 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8'
        >
          {{#each this.pageCollection.data as |pokemon|}}
            <PokemonGridItem @pokemon={{pokemon}} />
          {{/each}}
          <div
            {{didIntersect onEnter=this.lastReached options=observerOptions}}
          ></div>
        </div>
      </:content>
      <:loading>
        <LoadingBar />
      </:loading>
    </Request>

    {{outlet}}
    {{! template-lint-disable no-whitespace-for-layout }}
    {{! prettier-ignore }}
    <style>
      @keyframes reveal {
        from {
          opacity: 0;
          transform: scale(0.75);
        }
        to {
          opacity: 1;
          transform: scale(1);
        }
      }
      .revealing-image {
        /* Create View Timeline */
        view-timeline-name: --revealing-image;
        view-timeline-axis: block;

        /* Attach animation, linked to the  View Timeline */
        animation: linear reveal both;
        animation-timeline: --revealing-image;

        /* Tweak range when effect should run*/
        animation-range: entry 0% cover 25%;
      }
    </style>
  </template>
}
