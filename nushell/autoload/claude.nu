
export def claude-mm [...rest] {
    let model = "MiniMax-M2.5"
    let new_env = {
        ANTHROPIC_BASE_URL: $"($env.MINIMAX_API_HOST)/anthropic"
        ANTHROPIC_AUTH_TOKEN: $env.MINIMAX_API_KEY
        ANTHROPIC_MODEL: $model
        ANTHROPIC_SMALL_FAST_MODEL: $model
        ANTHROPIC_DEFAULT_SONNET_MODEL: $model
        ANTHROPIC_DEFAULT_OPUS_MODEL: $model
        ANTHROPIC_DEFAULT_HAIKU_MODEL: $model
        API_TIMEOUT_MS: 3000000
        CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC: 1
    }

    with-env $new_env { claude ...$rest }
}
