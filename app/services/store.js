import RequestManager from '@ember-data/request';
// eslint-disable-next-line ember/use-ember-data-rfc-395-imports
import Store from 'ember-data/store';
import Fetch from '@ember-data/request/fetch';
import { JsonSuffixHandler } from 'ember-polaris-pokedex/utils/handlers';

export default class StoreService extends Store {
  constructor() {
    super(...arguments);
    this.requestManager = new RequestManager();
    this.requestManager.use([JsonSuffixHandler, Fetch]);
  }
}
