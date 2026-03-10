<template>
    <div class="flex flex-row gap-4">
        <UCard class="min-w-sm max-w-sm">
            <div class="mb-2">
                <h3 class="text-xl font-semibold">Let's Connect</h3>
            </div>
            <div class="flex flex-col gap-2">
                <UButton
                    color="neutral"
                    icon="i-lucide-mail"
                    class="justify-center"
                    to="mailto:nugrahanaufalhafizh@gmail.com"
                >
                    Email Me
                </UButton>
                <UButton
                    color="neutral"
                    variant="outline"
                    icon="i-lucide-github"
                    class="justify-center"
                    to="https://github.com/valfidz"
                >
                    GitHub
                </UButton>
                <UButton
                    color="neutral"
                    variant="outline"
                    icon="i-lucide-linkedin"
                    class="justify-center"
                    to="https://linkedin.com/in/nhafizh"
                >
                    LinkedIn
                </UButton>
            </div>
        </UCard>
        <UCard class="min-w-sm max-w-sm">
            <div class="flex flex-col gap-4">
                <div class="flex flex-row gap-2">
                    <span><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-file-text-icon lucide-file-text"><path d="M6 22a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h8a2.4 2.4 0 0 1 1.704.706l3.588 3.588A2.4 2.4 0 0 1 20 8v12a2 2 0 0 1-2 2z"/><path d="M14 2v5a1 1 0 0 0 1 1h5"/><path d="M10 9H8"/><path d="M16 13H8"/><path d="M16 17H8"/></svg></span>
                    <h3 class="text-xl font-semibold">
                        Resume / CV
                    </h3>
                </div>
                <div>
                    <p>Download my complete resume with detailed experience, projects, and technical skills.</p>
                </div>
                <div class="flex justify-center">
                    <UButton
                        icon="i-lucide-download"
                        color="neutral"
                        size="lg"
                        to="https://bit.ly/CV-Softdev"
                        target="_blank"
                        class="w-full justify-center"
                    >
                        Download Resume
                    </UButton>
                </div>
            </div>
        </UCard>
    </div>
</template>