import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import HomeButton from 'ember-embroider-pokedex/components/home-button';

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'About'}}

    <HomeButton />
    <h2 class='font-medium text-4xl mb-4'>About</h2>
    <p class='text-xl mb-4 text-slate-700'>Ember Polaris Pokedex is a reference
      application to showcase modern Ember developments.</p>
    <p class='text-xl mb-2 text-slate-700'>It is built using the latest
      bleeding-edge technologies available:</p>
    <ul class='text-xl list-disc list-inside text-slate-700 space-y-1'>
      <li>
        <a
          href='https://vitejs.dev/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >⚡️ Vite-based</a>
        <a
          href='https://github.com/embroider-build/embroider'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >Embroider</a></li>
      <li>
        <a
          href='https://volarjs.dev/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >🔥 Volar-based</a>
        <a
          href='https://typed-ember.gitbook.io/glint'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >Glint</a></li>
      <li>
        <a
          href='https://blog.emberjs.com/stable-typescript-types-in-ember-5-1/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >💙 Native Ember TypeScript types from source</a></li>
      <li>
        <a
          href='https://guides.emberjs.com/release/components/template-tag-format/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >📦 Template-tag components ('.gjs', '.gts')</a>
        <ul class='list-inside ps-5 mt-2 space-y-1 list-[circle]'>
          <li>
            <a
              href='https://github.com/discourse/ember-route-template'
              target='_blank'
              class='hover:underline'
              rel='noopener noreferrer'
            >ember-route-template</a>
            for template tag as route templates</li>
        </ul>
      </li>
      <li>
        <a
          href='https://warp-drive.io/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >🚀 Warp Drive</a>
        <ul class='list-inside ps-5 mt-2 space-y-1 list-[circle]'>
          <li>'@warp-drive/ember' Request component</li>
          <li>Ember Data request builders</li>
          <li>Native TypeScript types</li>
        </ul>
      </li>
    </ul>
  </template>
}
