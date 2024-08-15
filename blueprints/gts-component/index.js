'use strict';

/* eslint-disable ember/no-string-prototype-extensions */
// eslint-disable-next-line n/no-missing-require
const stringUtil = require('ember-cli-string-utils');

function invocationFor(options) {
  let parts = options.entity.name.split('/');
  return parts.map((p) => stringUtil.classify(p)).join('::');
}

function cssFor(options) {
  let parts = options.entity.name.split('/');
  return parts.map((p) => stringUtil.dasherize(p)).join('_');
}

module.exports = {
  description: '',

  locals(options) {
    return {
      looseTemplateInvocation: invocationFor(options),
      cssifiedModuleName: cssFor(options),
      templateStart: '<template>',
      templateEnd: '</template>',
    };
  },
};
