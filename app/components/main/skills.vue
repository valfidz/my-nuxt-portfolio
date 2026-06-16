<script setup lang="ts">
const { data: skills } = await useFetch<{
  id: string
  title: string
  stacks: string[]
}[]>('/api/skills')
</script>

<template>
  <div id="skills" class="flex flex-col mt-10">
    <UPageHeader
      title="Technical Skills"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex justify-center">
      <div class="flex flex-wrap gap-6 max-w-2xl">
        <MainSkillCard
          v-for="skill in (skills ?? [])"
          :key="skill.id"
          :title="skill.title"
          :stacks="skill.stacks"
        />
      </div>
    </div>
  </div>
</template>
