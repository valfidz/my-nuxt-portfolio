<template>
  <div class="flex flex-col mt-10">
    <UPageHeader
      title="Latest Blog Posts"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-col gap-6 items-center">
      <MainBlogCard />
      <MainBlogCard />
    </div>
  </div>
</template>