# POC - SQL Server Data Tools (pt-br)

## Sumário
* [Propósito](#proposito)
* [Dependências](#denpendencias)
* [Bases](#bases)
* [CI/CD](#ci/cd)
* [Resultados](#resultados)
* [Considerações](#consideracoes)
* [Tutoriais e apresentações](#tutoriais-e-apresentacoes)
* [Pesquisas e soluções de problemas](#pesquisas-e-solucoes-de-problemas)
* [Contribuição](#contribuicao)

## Propósito
Propósito deste projeto é realizar testes usando da ferramenta SSDT para a realização de sincronismo entre bases, mediante atividades da equipe de BI. Atividades e dúvidas que serão atacadas nesta prova de conceito são:
- [x] Definir ambientes de dev, inicio e fim de deploys<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Criados bancos ssdt_0X, porêm o desenvolvimento acontede offline (local) em máquina do desenvolvedor._

- [ ] É necessária adição da criação de schema?<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - A definir._<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_**TODO:** Averiguar se configuração (Project Settings > General > Default schema) supre necessidade de informar schema._

- [x] Criação/alteração de estutura (tables, columns)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Executada integração VSTS com nome de banco não existente, banco, tabelas e procedimentos criados a partir do nome configurado na tarefa de release do VSTS. Para banco já existente, apenas tabelas e procedimentos foram adicionados._

- [x] Input de dados (insert)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Podem ser incluídos scripts de pré e post deploy no projeto de Data Base, dessa forma podem ser executados scripts antes ou depois da migração das estruturas da base em questão._

- [X] Alteração de estutura/input de dados (insert - ex. domínios)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Foi possível a alteração da estrutura de uma tabela mesmo com erro no script de post deployment, dessa forma ainda precisamos avaliar a possibilidade de rollback no próprio passo de CD._

- [X] Criação/alteração de programaticas (view, proc e func)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Alteração de programáticas se dá da mesma forma da estrutura de tabelas, CI/CD não valida se procedure, por exemplo, não possui todos campos de tabela previamente alterada._

- [ ] Criação/alteração de índices (tabelas populadas)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Realizei um teste simples criando um indice clusterizado, a build apresentou erro uma vez que não se pode ter mais de um por tabela, existe validação em ponto de build._<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_**TODO**: verificar mais necessidades._

- [X] Dentro/fora de projeto web (trigger no VSTS)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - É algo a ser avaliado em cada situação, ex. uma aplicação não deve possuir scripts que possam estar contidos em outra aplicação._<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

- [X] Importar para projeto Banco de Dados já existente<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Importanção foi realizada sem problemas após permissões adicionadas ao usuário de teste._

- [X] Possível utilização do Visual Studio Code para desenvolvimento de banco?<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
_R - Sim, uma vez que as alterações a serem promovidas são aquelas que estão sendo enviadas para o repositório Git. Extensão [MSSQL](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) para VSCode auxilia nas atividades realizando conexões com bases (MSSQL, Azure ...), auxílio a escrita de T-SQL com intellisense, entre outras features_

## Dependências
* Pacotes/frameworks: 
  + Nome: [SQL Server Data Tools](https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-2017)
  + Erro de instalação: caso tenha problemas com a instalação, erro: _Recursion too deep; the stack overflowed (0x800703E9)_, veja solução adicionada ao [stackoverflow](https://stackoverflow.com/questions/46421619/ssdt-installation-issue-failed-to-execute-exe-package)

## Bases
* **Projeto**: PocSSDT.DataBase (Visual Studio SQL Server Project)
* **Servidor**: server001
* **Bases**: ssdt001
* **Usuario/senha**: usrssdt/*******

## CI/CD
Será realizado via **Azure DevOps**, em [Build e Release](https://companhia.azure.dev/projeto/_build)

## Resultados
1. Resultados iniciais demonstram que estando bem alinhado entre as células de BI as reponsabilidades entre as bases, é possível a manutenção de projetos de banco de dados a partir de Projeto Data Base do Visual Studio utilizando da extensão SSDT (Sql Server Data Tools).
2. Controle de versionamento utilizando [Git](https://git-scm.com/) garante identificação de problemas de conflito entre versões e evita sobrescrita de alterações por parte de colaboradores/fornecedores, o que se torna uma ferramenta essencial na gestão de nossas bases e evita aquele temido ".bkp" em diretórios espalhados em computadores e servidores da organização.
3. Processos de CI/CD tem suas particularidades com relações às configurações nas VMs dentro do Azure (VNET e WinRM). Este mesmo processo auxilia os times com feedback imediato a cada nova versão da base, o que ajuda na identicação e resolução de forma mais ágil.<br />

## Considerações
SSDT realiza a manutenção baseada no estado entre projeto de banco de dados (offline - Visual Studio) e banco de destino (realizado via CD no VSTS), resultado gera o script de alteração (.DACPAC) para que o banco de destino esteja de acordo com o do projeto, dessa forma ajuda na manutenção de bases mantendo elas sincronizadas e não necessitade intervenção manual e necessidade de banco para desenvolvimento, podendo o desenvolvedor criar uma base local para auxiliar suas tarefas.

## Tutoriais e apresentações
1. [SQL Server Data Tools Team Blog](https://blogs.msdn.microsoft.com/ssdt/2016/04/06/sqldb-cicd-intro/) (MSDN)
2. [SQL Server Data Tools for Visual Studio](https://channel9.msdn.com/Shows/Visual-Studio-Toolbox/SQL-Server-Data-Tools-for-Visual-Studio) (Channel 9)
3. [SQL Server Data Tools in your DevOps pipeline](https://channel9.msdn.com/Shows/Visual-Studio-Toolbox/SQL-Server-Data-Tools-in-your-DevOps-pipeline) (Channel 9)
4. [Database Continuous Integration with Visual Studio SQL Server Data Tools](https://www.youtube.com/watch?v=K1BJ43GAPQk) (Youtube)

## Pesquisas e soluções de problemas
* [Delivering databases migrations vs state](http://webcache.googleusercontent.com/search?q=cache:05vPuwwtU80J:workingwithdevs.com/delivering-databases-migrations-vs-state/+&cd=4&hl=en&ct=clnk&gl=br)
* [An overview of SSDT](https://blogs.msdn.microsoft.com/premier_developer/2017/07/01/an-overview-of-ssdt/)
* [Continuous Integration with SQL Server Data Tools in Visual Studio 2017](https://www.sqlshack.com/continuous-integration-sql-server-data-tools-visual-studio-2017/)
* [Including Data in a SQL Server Database Project](https://blogs.msdn.microsoft.com/ssdt/2012/02/02/including-data-in-a-sql-server-database-project/)
* [Manage lookup data using SQL Server Data Tools (SSDT)](https://www.benday.com/2015/12/05/manage-lookup-data-using-sql-server-data-tools-ssdt/)
* [Basic Database Continuous Integration and Delivery (CI/CD) using Visual Studio Team Services (VSTS)](http://www.dotnetcurry.com/visualstudio/1290/deploy-dacpac-sqlserver-azure-vm-using-vsts)
* [Deploy: Azure File Copy](https://docs.microsoft.com/en-us/vsts/pipelines/tasks/deploy/azure-file-copy?view=vsts)
* [VSTS Run Powershell on Target Machines - Access is Denied error](https://social.msdn.microsoft.com/Forums/vstudio/en-US/7ebda2d0-5c99-4d48-b18b-da4ed5785b98/vsts-run-powershell-on-target-machines-access-is-denied-error?forum=tfsbuild)
* [Rolling back a failed DACPAC with SqlPackage.exe](https://stackoverflow.com/questions/39707351/rolling-back-a-failed-dacpac-with-sqlpackage-exe)

## Contribuição
Se deseja contribuir saiba mais sobre a formatação do arquivo README, veja em [Guia de Sintax](https://docs.microsoft.com/en-us/vsts/project/wiki/markdown-guidance?view=vsts)
