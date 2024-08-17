import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'Ember Pokedex'}}

    <main class='container m-auto py-8 min-h-screen'>
      <div class='flex justify-between text-5xl mb-6 font-extrabold'>
        <h2>
          <LinkTo
            @route='index'
            class='text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-600'
          >
            Ember Pokedex
          </LinkTo>
          📕🔍✨
        </h2>
        <LinkTo @route='about' class='drop-shadow hover:drop-shadow-lg'>
          ℹ️
        </LinkTo>
      </div>

      {{outlet}}
    </main>
    <footer class='container m-auto py-8'>
      Pokémon and all elements of the Pokémon franchise are © 1995-2024
      Nintendo, GAME FREAK inc. TM © and Creatures Inc.
    </footer>
  </template>
}
