<#
.SYNOPSIS
    Filtra e limpa os agentes do Antigravity/ECC, mantendo apenas os especialistas relevantes para a sua stack.

.DESCRIPTION
    O instalador do ECC baixa por padrao todos os 71 agentes (incluindo PHP, Swift, Ruby, Rust, Python, etc.).
    Este script automatiza a selecao, removendo os agentes de outras linguagens e nichos irrelevantes,
    economizando contexto de tokens e deixando o projeto muito mais rapido e organizado.

.PARAMETER Profile
    'dotnet' (Padrao): Mantem os agentes essenciais para .NET / C# (Arquitetura, C#, SQL/EF, TDD, Seguranca, Refatoracao, Performance).
    'dotnet-fullstack': Mantem o perfil dotnet + TypeScript, React, Vue, Acessibilidade e E2E.
    'minimal': Mantem apenas o Top 10 essencial (Architect, CSharp, TDD, Security, CodeReview, Database, BuildError, Performance, Refactor, SpecMiner).

.PARAMETER TargetPath
    Caminho para o diretorio raiz do projeto ou pasta .agent (padrao: pasta atual).

.PARAMETER DryRun
    Se verdadeiro, apenas exibe a simulacao sem deletar nenhum arquivo.

.EXAMPLE
    .\scripts\curate-agents.ps1
    Executa a limpeza padrao para projetos C# / ASP.NET Core no projeto atual.

.EXAMPLE
    .\scripts\curate-agents.ps1 -Profile minimal -TargetPath "D:\Dev\Gestao_Frotas"
    Aplica o perfil minimo no projeto Gestao_Frotas.
#>
[CmdletBinding()]
param(
    [ValidateSet('dotnet', 'dotnet-fullstack', 'minimal')]
    [string]$Profile = 'dotnet',

    [string]$TargetPath = ".",

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

# Localizar pasta .agent/agents
$agentsDir = $null
if (Test-Path (Join-Path $TargetPath ".agent\agents")) {
    $agentsDir = Join-Path $TargetPath ".agent\agents"
} elseif (Test-Path (Join-Path $TargetPath "agents")) {
    $agentsDir = Join-Path $TargetPath "agents"
} else {
    Write-Error "Nao foi possivel encontrar a pasta de agentes em '$TargetPath'. Certifique-se de apontar para a raiz do projeto que contem a pasta .agent."
    exit 1
}

Write-Host "[INFO] Analisando agentes em: $agentsDir" -ForegroundColor Cyan
Write-Host "[INFO] Perfil selecionado: $Profile" -ForegroundColor Cyan

# Listas de Agentes por Perfil
$minimalAgents = @(
    "architect.md",
    "csharp-reviewer.md",
    "tdd-guide.md",
    "security-reviewer.md",
    "code-reviewer.md",
    "database-reviewer.md",
    "build-error-resolver.md",
    "performance-optimizer.md",
    "refactor-cleaner.md",
    "spec-miner.md"
)

$dotnetCoreAgents = $minimalAgents + @(
    "code-architect.md",
    "code-explorer.md",
    "code-simplifier.md",
    "commit-reviewer.md",
    "doc-updater.md",
    "docs-lookup.md",
    "e2e-runner.md",
    "fsharp-reviewer.md",
    "planner.md",
    "pr-test-analyzer.md",
    "silent-failure-hunter.md",
    "type-design-analyzer.md",
    "agent-evaluator.md"
)

$fullstackExtra = @(
    "a11y-architect.md",
    "typescript-reviewer.md",
    "react-reviewer.md",
    "react-build-resolver.md",
    "vue-reviewer.md"
)

# Definir agentes permitidos com base no perfil
$allowedAgents = @()
switch ($Profile) {
    'minimal' {
        $allowedAgents = $minimalAgents
    }
    'dotnet' {
        $allowedAgents = $dotnetCoreAgents
    }
    'dotnet-fullstack' {
        $allowedAgents = $dotnetCoreAgents + $fullstackExtra
    }
}

$allFiles = Get-ChildItem -File -Path $agentsDir -Filter "*.md"
$removedCount = 0
$keptCount = 0

Write-Host "`n[PROCESSANDO] Verificando agentes..." -ForegroundColor Yellow

foreach ($file in $allFiles) {
    if ($allowedAgents -contains $file.Name) {
        Write-Host "  [MANTER] $($file.Name)" -ForegroundColor Green
        $keptCount++
    } else {
        if ($DryRun) {
            Write-Host "  [SIMULACAO REMOCAO] $($file.Name)" -ForegroundColor DarkGray
        } else {
            Remove-Item -LiteralPath $file.FullName -Force
            Write-Host "  [REMOVIDO] $($file.Name)" -ForegroundColor DarkGray
        }
        $removedCount++
    }
}

Write-Host "`n[RESUMO] Curadoria de Agentes concluida:" -ForegroundColor Cyan
Write-Host "   - Agentes Mantidos:  $keptCount" -ForegroundColor Green
Write-Host "   - Agentes Removidos: $removedCount" -ForegroundColor Yellow
if ($DryRun) {
    Write-Host "   (Modo DryRun: nenhum arquivo foi realmente excluido)" -ForegroundColor Magenta
} else {
    Write-Host "   (Projeto especializado para a stack: $Profile!)" -ForegroundColor Green
}
