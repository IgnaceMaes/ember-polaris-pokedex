import Route from '@ember/routing/route';
import type Controller from '@ember/controller';

export type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

export type RouteTemplateSignature<
  R extends Route,
  C extends Controller | undefined = undefined,
> = C extends Controller
  ? {
      Args: {
        model: ModelFrom<R>;
        controller: C;
      };
    }
  : {
      Args: {
        model: ModelFrom<R>;
      };
    };

export { default as RouteTemplate } from 'ember-route-template';
