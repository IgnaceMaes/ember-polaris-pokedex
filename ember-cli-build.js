'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
const { maybeEmbroider } = require('@embroider/test-setup');

module.exports = async function (defaults) {
  const { setConfig } = await import('@warp-drive/build-config');
  const app = new EmberApp(defaults, {
    'ember-cli-babel': { enableTypeScriptTransform: true },

    // Add options here
  });

  setConfig(app, __dirname, {
    compatWith: '99.0',
  });

  return maybeEmbroider(app, {
    skipBabel: [
      {
        package: 'qunit',
      },
    ],
    staticAppPaths: ['data-worker'],
  });
};
