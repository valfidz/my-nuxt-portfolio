<template>
    <div class="flex flex-col mt-10">
        <div>
            <UPageHeader
                title="Get In Touch"
                :ui="{
                    root: 'border-b-0',
                    title: 'mx-auto'
                }" 
            />
        </div>
        <div class="flex flex-col gap-6 justify-center items-center">
            <div>
                <p>I'm always interested in discussing new opportunities, collaborating on projects, or simply talking about technology.</p>
            </div>
            <MainContactCard />
        </div>
    </div>
</template>