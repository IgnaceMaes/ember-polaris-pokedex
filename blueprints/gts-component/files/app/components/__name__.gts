import Component from '@glimmer/component';

interface <%= classifiedModuleName %>Signature {
  Args: { };
  Element: HTMLDivElement;
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class <%= classifiedModuleName %> extends Component<<%= classifiedModuleName %>Signature> {
  <%= templateStart %>
    <p>&lt;<%= looseTemplateInvocation %>&gt; component</p>
  <%= templateEnd %>
}

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    '<%= looseTemplateInvocation %>': typeof <%= classifiedModuleName %>;
    '<%= dasherizedModuleName %>': typeof <%= classifiedModuleName %>;
  }
}
