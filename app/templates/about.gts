import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'About'}}

    <LinkTo
      @route='index'
      class='relative inline-flex items-center justify-center p-0.5 mb-16 me-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-pink-500 to-orange-400 group-hover:from-pink-500 group-hover:to-orange-400 hover:text-white focus:ring-4 focus:outline-none focus:ring-pink-200'
    >
      <span
        class='relative px-5 py-2.5 transition-all ease-in duration-75 bg-white rounded-md group-hover:bg-opacity-0'
      >⬅️ back
      </span>
    </LinkTo>
    <h2 class='font-medium text-4xl mb-4'>About</h2>
    <p>Ember Polaris Pokedex is built with the latest bleeding-edge technologies
      available in the Ember world.</p>
    <ul>
      <li>—
        <a
          href='https://vitejs.dev/'
          target='_blank'
          class='hover:underline'
        >Vite</a></li>
      <li>—
        <a
          href='https://volarjs.dev/'
          target='_blank'
          class='hover:underline'
        >Volar-based</a>
        <a
          href='https://typed-ember.gitbook.io/glint'
          target='_blank'
          class='hover:underline'
        >Glint</a></li>
      <li>— <a href='https://blog.emberjs.com/stable-typescript-types-in-ember-5-1/' target='_blank' class='hover:underline'>Native Ember TypeScript types from source</a></li>
      <li>— <a href='https://guides.emberjs.com/release/components/template-tag-format/' target='_blank' class='hover:underline'>Template-tag components ('.gjs', '.gts')</a></li>
      <li>——— <a href='https://github.com/discourse/ember-route-template' target='_blank' class='hover:underline'>ember-route-template</a> for template tag as route templates</li>
      <li>— <a href='https://warp-drive.io/' target='_blank' class='hover:underline'>Warp Drive</a></li>
      <li>——— '@warp-drive/ember' Request component</li>
      <li>——— Ember Data request builders</li>
      <li>——— Native TypeScript types</li>
    </ul>
  </template>
}
