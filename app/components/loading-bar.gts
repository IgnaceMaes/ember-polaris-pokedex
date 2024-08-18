import type { TOC } from '@ember/component/template-only';

const LoadingBar: TOC<object> = <template>
  <div class='w-full absolute top-0 right-0'>
    <div class='h-1.5 w-full bg-pink-100 overflow-hidden'>
      <div
        class='animate-progress w-full h-full bg-pink-500 origin-left-right'
      ></div>
    </div>
  </div>
</template>;

export default LoadingBar;
