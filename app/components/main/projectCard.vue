<template>
  <NuxtLink to="#" class="block w-full sm:w-80">
    <UCard class="h-full hover:ring-2 hover:ring-primary transition-all duration-200">
      <div class="flex flex-col gap-4 h-full">
        <h3 class="text-xl font-semibold">Simple World Map</h3>
        <div class="flex flex-row flex-wrap gap-2">
          <UBadge color="neutral" variant="soft" label="Bun" />
          <UBadge color="neutral" variant="soft" label="Javascript" />
          <UBadge color="neutral" variant="soft" label="Svelte" />
          <UBadge color="neutral" variant="soft" label="Sveltekit" />
          <UBadge color="neutral" variant="soft" label="Supabase" />
        </div>
        <p class="text-muted text-sm mt-auto">Simple world map built by svelte and supabase</p>
      </div>
    </UCard>
  </NuxtLink>
</template>