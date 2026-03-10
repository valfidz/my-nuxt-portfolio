<template>
  <div id="skills" class="flex flex-col mt-10">
    <UPageHeader
      title="Technical Skills"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-wrap justify-center gap-6">
      <MainSkillCard />
      <MainSkillCard />
    </div>
  </div>
</template>