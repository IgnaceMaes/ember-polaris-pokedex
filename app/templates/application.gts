import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'Ember Pokedex'}}

    <main class='container m-auto py-8 min-h-screen'>
      <h2 class='text-5xl mb-4 font-extrabold'>
        <span
          class='text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-600'
        >
          Ember Pokedex
        </span>
        📕🔍✨
      </h2>

      {{outlet}}
    </main>
    <footer class='container m-auto py-8'>
      Pokémon and all elements of the Pokémon franchise are © 1995-2024
      Nintendo, GAME FREAK inc. TM © and Creatures Inc.
    </footer>
  </template>
}
