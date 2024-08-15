import '@glint/environment-ember-loose';
import { ComponentLike } from '@glint/template';
import type EmberPageTitleTemplateRegistry from 'ember-page-title/template-registry';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry extends EmberPageTitleTemplateRegistry {
    WelcomePage: ComponentLike;
  }
}
