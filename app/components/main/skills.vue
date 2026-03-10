<template>
    <div class="flex flex-col mt-10">
        <div>
            <UPageHeader
                title="Technical Skills"
                :ui="{
                    root: 'border-b-0',
                    title: 'mx-auto'
                }" 
            />
        </div>
        <div class="flex flex-row flex-wrap gap-6 justify-center">
            <MainSkillCard />
            <MainSkillCard />
        </div>
    </div>
</template>