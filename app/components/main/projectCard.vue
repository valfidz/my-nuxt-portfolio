<script setup lang="ts">
import type { PropType } from 'vue';

const props = defineProps({
  title: String,
  stacks: {
    type: Array as PropType<string[]>,
    default: () => []
  },
  description: String,
  link: String,
})
</script>

<template>
  <NuxtLink :to="props.link" target="_blank" class="block w-full sm:w-80">
    <UCard class="h-full hover:ring-2 hover:ring-primary transition-all duration-200">
      <div class="flex flex-col gap-4 h-full">
        <h3 class="text-xl font-semibold">{{ props.title }}</h3>
        <div class="flex flex-row flex-wrap gap-2">
          <UBadge
            v-for="(stack, index) in stacks"
            :key="index"
            color="neutral"
            variant="soft"
            :label="stack"
          />
        </div>
        <p class="text-muted text-sm mt-auto">{{ props.description }}</p>
      </div>
    </UCard>
  </NuxtLink>
</template>