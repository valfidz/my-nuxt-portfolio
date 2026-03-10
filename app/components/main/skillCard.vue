<script setup lang="ts">
import type { PropType } from 'vue';

const props = defineProps({
  title: String,
  stacks: Array as PropType<string[]>
})
</script>

<template>
  <UCard class="w-full sm:w-80">
    <div class="flex flex-col gap-2">
      <h3 class="text-xl font-semibold">{{ props.title }}</h3>
      <div class="flex flex-row flex-wrap gap-2">
        <UBadge
          v-for="(stack, index) in stacks"
          color="neutral"
          variant="soft"
          :key="index"
          :label="stack"
        />
      </div>
    </div>
  </UCard>
</template>