# Email Notifier

[![Build Status](https://travis-ci.org/umovme/email-notifier.svg?branch=master)](https://travis-ci.org/umovme/email-notifier)

##1. Introdução
O Email-notifier é um serviço que envia email contendo os dados obtidos em atividades executadas na plataforma uMov.me.
O envio do email está condicionado a regras estabelecidas em um arquivo de configuração (email_rules.yml) responsável por mapear em cada regra os campos correspondentes no arquivo exportado.

##2. Instalação
Para executar o Email-notifier é preciso realizar os passos abaixo

####2.1. Instalar Ruby
O serviço foi desenvolvido na linguagem ruby, por isso é necessário instalar esta a linguagem na máquina onde o serviço será executado. Os instaladores podem ser obtidos em: 
* Windows: http://rubyinstaller.org/
* Unix based: https://www.ruby-lang.org/en/

####2.2) Instalar Ruby Gems
Além do Ruby é necessário instalar o RubyGem, que é uma biblioteca, um conjunto de arquivos Ruby reusáveis, necessário para executar programas desenvolvidos na linguagem ruby.
* Pode ser obtido em https://rubygems.org

####2.3. Download do Serviço
O serviço está disponibilizado publicamente em https://github.com/umovme/email-notifier e existem duas maneira de baixá-lo:
* Realizar o download do [arquivo zip](https://github.com/umovme/email-notifier/archive/master.zip)
* Clonar o projeto executando o comando: `git clone https://github.com/umovme/email-notifier.git`

####2.4. Instalando o Email-notifier
Após baixar o serviço, acesse o diretório **/email-notifier** (caso baixar o zip então o diretorio será **/email-notifier-master**) e execute o comando abaixo para configurar a aplicação:
`ruby setup.rb`
Após a execução do `setup.rb` serão criadas as pastas **/file-to-process** e a **log**

##3. Configuração
O arquivo CSV contendo os dados exportados deve ser incluído na pasta **/file-to-process**
	
####3.1. Configuração do servidor de email
O arquivo **conf/email_options.yml** destina-se à configuração do servidor de SMTP onde devem ser inseridas as credenciais e a sintaxe apresentada abaixo:
```
config:
  address: smtp.gmail.com
  port: 587
  enable_starttls_auto: true
  user_name: user@company
  password: 987654321
  domain: localhost.localdomain

condition_value: TRUE
```

####3.2. Configuração das regras para envio de email
O arquivo **conf/email_rules.yml** destina-se à regras onde serão mapeados os campos da atividade.
Cada regra contém como parâmetro um identificador da regra (rule_id) para faciliar na leitura dos logs, os campos do email (to,cc,subject,body) e uma condição que serão mapeados com os campos do arquivo de exportação.
Os parâmetros *to*, *subject* são obrigatórios e o email não será enviado caso algum deles esteja vazio ou nulo. O parâmetro *condition* também é obrigatório, nele é atribuio a variável de condição para envio do email. Esta variável é especificada no parâmetro *condition_value* do arquivo **conf/email_options.yml** e deve conter o mesmo valor para o campo destinado a condição/validação do arquivo exportado.
Igualmente ao arquivo de configuração do servidor SMTP, este arquivo segue uma sintaxe própria e deve ser respeitada
```	
---
- rule_id: 1
  to: RULE1_TO
  cc: RULE1_CC
  subject: RULE1_SUBJECT
  body: RULE1_BODY
  condition: RULE1_CONDITION

- rule_id: 2
  to: RULE2_TO
  cc: RULE2_TO
  subject: RULE2_SUBJECT
  body: RULE2_BODY
  condition: RULE2_CONDITION
```
##4. Executar o serviço
Visto que a instalação e configuração foram realizadas, então o serviço está pronto para ser executado, para tanto execute o comando abaixo. 
`ruby run.rb`
##5. Verificação dos logs do serviço
O arquivo de log é gerado a cada execução do serviço, caso ainda não exista, e serve para informar basicamente o número de regras mapeadas, a linha que está sendo processada e se os email foram enviados ou não.




