import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-polaris-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

@RouteTemplate
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'Ember Polaris Pokedex'}}

    <main class='container m-auto min-h-screen px-4 py-8'>
      <div class='mb-6 flex justify-between text-5xl font-extrabold gap-4'>
        <h2>
          <LinkTo
            @route='index'
            class='bg-gradient-to-r from-red-400 to-pink-600 bg-clip-text text-transparent'
          >
            Ember Polaris Pokedex
          </LinkTo>
          📕🔍✨
        </h2>
        <LinkTo @route='about' class='drop-shadow hover:drop-shadow-lg'>
          ℹ️
        </LinkTo>
      </div>

      {{outlet}}
    </main>
    <footer class='container m-auto px-4 py-8 text-sm text-slate-700'>
      <p class='font-bold'>© 2024 Ember Polaris Pokedex.</p>
      <p>Pokémon and all related trademarks, characters, and images are
        ©1995-2024 Nintendo, Creatures, GAME FREAK, and The Pokémon Company.
        This fan site is not affiliated with or endorsed by any of these
        entities.</p>
    </footer>
  </template>
}
