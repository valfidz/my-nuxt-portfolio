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
      <MainProjectCard />
      <MainProjectCard />
    </div>
  </div>
</template>