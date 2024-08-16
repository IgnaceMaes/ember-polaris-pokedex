import RouteTemplate from 'ember-route-template';
import { pageTitle } from 'ember-page-title';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';
import Component from '@glimmer/component';
import type Route from '@ember/routing/route';
import type IndexRoute from 'ember-embroider-pokedex/routes';
import type Controller from '@ember/controller';
import { Request } from '@warp-drive/ember';

type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

type RouteTemplateSignature<
  R extends Route,
  C extends Controller | undefined = undefined,
> = C extends Controller
  ? {
      Args: {
        model: ModelFrom<R>;
        controller: C;
      };
    }
  : {
      Args: {
        model: ModelFrom<R>;
      };
    };

declare module 'ember-route-template' {
  export default function RouteTemplate(Component: object): void;
}

class RouteComponent<
  R extends Route,
  C extends Controller | undefined = undefined,
> extends Component<RouteTemplateSignature<R, C>> {}

@RouteTemplate
export default class IndexTemplate extends RouteComponent<IndexRoute> {
  <template>
    {{pageTitle 'Overview'}}

    <h3 class='text-2xl font-medium mb-2'>Overview</h3>

    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        <div class='grid grid-cols-8 gap-4'>
          {{#each PokemonContent.data as |pokemon|}}
            <Pokemon @pokemon={{pokemon}} />
          {{/each}}
        </div>
      </:content>
      <:loading>
        <div>Loading...</div>
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
