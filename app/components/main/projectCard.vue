<template>
    <NuxtLink to="#">
        <UCard>
            <div class="flex flex-col flex-wrap gap-4 max-w-sm">
                <div>
                    <h3 class="text-xl font-semibold">
                        Simple World Map
                    </h3>
                </div>
                <div class="flex flex-row flex-wrap gap-2">
                    <UBadge color="neutral" variant="soft" label="Bun" />
                    <UBadge color="neutral" variant="soft" label="Javascript" />
                    <UBadge color="neutral" variant="soft" label="Svelte" />
                    <UBadge color="neutral" variant="soft" label="Sveltekit" />
                    <UBadge color="neutral" variant="soft" label="Supabase" />
                </div>
                <div>Simple world map built by svelte and supabase</div>
            </div>
        </UCard>
    </NuxtLink>
</template>