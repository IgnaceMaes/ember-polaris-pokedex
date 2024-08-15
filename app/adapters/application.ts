import JSONAPIAdapter from '@ember-data/adapter/json-api';

export default class ApplicationAdapter extends JSONAPIAdapter {
  buildURL(...args) {
    return `${super.buildURL(...args)}.json`;
  }
}
