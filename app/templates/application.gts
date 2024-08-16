import { pageTitle } from 'ember-page-title';
import { RouteComponent, RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';

@RouteTemplate
export default class ApplicationTemplate extends RouteComponent {
  <template>
    {{pageTitle 'Ember Pokedex'}}

    <main class="container m-auto py-8">
      <h2 class="text-4xl font-bold mb-4">Ember Pokedex</h2>

      {{outlet}}
    </main>
    <footer class="container m-auto py-8">
      Pokémon and all elements of the Pokémon franchise are © 1995-2024 Nintendo, GAME FREAK inc. TM © and Creatures Inc.
    </footer>
  </template>
}
