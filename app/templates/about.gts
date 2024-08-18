import { pageTitle } from 'ember-page-title';
import { RouteTemplate } from 'ember-polaris-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import HomeButton from 'ember-polaris-pokedex/components/home-button';

@RouteTemplate
export default class ApplicationTemplate extends Component {
  <template>
    {{pageTitle 'About'}}

    <HomeButton />
    <section class='text-xl text-slate-700'>
      <h2 class='mb-4 text-4xl font-medium'>About</h2>
      <p class='mb-4'>Ember Polaris Pokedex is a reference application to
        showcase what
        <a
          href='https://emberjs.com/editions/polaris/'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >the Ember Polaris edition</a>
        looks like. The source code is
        <a
          href='todo'
          target='_blank'
          class='hover:underline'
          rel='noopener noreferrer'
        >available on GitHub</a>.</p>
      <p class='mb-2'>The app is built using the latest bleeding-edge
        technologies available:</p>
      <ul class='list-inside list-disc space-y-1'>
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
          <ul class='mt-2 list-inside list-[circle] space-y-1 ps-5'>
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
          <ul class='mt-2 list-inside list-[circle] space-y-1 ps-5'>
            <li>'@warp-drive/ember' Request component</li>
            <li>Ember Data request builders</li>
            <li>Native TypeScript types</li>
          </ul>
        </li>
      </ul>
      <p class='mb-2 mt-6'>It also embraces web standards by making use of:</p>

      <ul class='list-inside list-disc space-y-1'>
        <li><a
            href='https://developer.chrome.com/docs/web-platform/view-transitions/same-document'
            target='_blank'
            class='hover:underline'
            rel='noopener noreferrer'
          >🔗 View transition API</a></li>
        <li><a
            href='https://scroll-driven-animations.style/'
            target='_blank'
            class='hover:underline'
            rel='noopener noreferrer'
          >🎥 Scroll-driven animations</a></li>
      </ul>
    </section>
  </template>
}
