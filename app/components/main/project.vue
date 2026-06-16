<script setup lang="ts">
const { data: projects } = await useFetch<{
  id: string
  title: string
  stacks: string[]
  description: string
  link: string
}[]>('/api/projects')
</script>

<template>
  <div id="projects" class="flex flex-col mt-10">
    <UPageHeader
      title="Featured Projects"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-wrap justify-center gap-6">
      <MainProjectCard
        v-for="project in (projects ?? [])"
        :key="project.id"
        :title="project.title"
        :stacks="project.stacks"
        :description="project.description"
        :link="project.link"
      />
    </div>
  </div>
</template>
