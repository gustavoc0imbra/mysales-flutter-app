# My Sales App 💰📋

Um aplicativo que visa facilitar a gestão de vendas de seu negócio.

## Stack utilizada:
- Dart
- Flutter

## Proposta de negócio:
- A proposta do projeto é trazer uma gestão facilitada para o proprietário do négócio.
- Visando trazer recursos básicos de negócios como:
- - Gestão de clientes e seus endereços
  - Gestão de produtos: margem de lucro que deseja em cima do preço, preço de compra do produto
  - Gestão de pedidos
  - Gestão de fluxo financeiro, tais como caixa, transações etc.
- Projeto possui integração com a ViaCEP para agilizar preenchimento de endereços.

## My Sales API
- API que gerencia todas as operações do aplicativo: [My Sales API](https://github.com/gustavoc0imbra/mysales-api)

## Como instalar e rodar o projeto:
1. Clonar este repositório no diretório desejado `git clone https://github.com/gustavoc0imbra/mysales-flutter-app.git`
2. Após clonar, pelo terminal acesso o diretório do projeto `cd mysales-flutter-app`
> [!NOTE]
> Para poder executar o próximo passo e executar o projeto é necessário ter o dart e flutter configurado em sua máquina  
3. Com o diretório acessado pelo terminal, execute o comando `flutter pub get`
4. Para executar basta digitar `flutter run` no terminal ou se estiver utilizando o visual studio code clique no botão de "play" para executar, como na imagem abaixo:
![flutter--vs-code](https://github.com/user-attachments/assets/37ef04f5-2385-4ff1-a5ef-6997e2566325)
5. Após isto será perguntado a plataforma que deseja executar: **Recomendado é o navegador de sua preferência**
6. Pronto após isto será exibido a primeira tela de clientes como no exemplo abaixo:  
![image](https://github.com/user-attachments/assets/9a98113d-b6e0-4a2d-8813-523d319d9269)

## Prévia telas:
### Adicionar Cliente:
![image](https://github.com/user-attachments/assets/71cebbde-5abf-4d54-95b4-f2d5e8e0c397)

### Endereços do cliente:
![image](https://github.com/user-attachments/assets/516e20ba-9b5f-439d-9f9e-afd78c18fe7f)

### Adicionar/Editar um endereço: Ao digitar o CEP o app automaticamente irá preencher o endereço
![image](https://github.com/user-attachments/assets/875abadc-4806-4ffc-9c30-ef04c17ea325)

## Manual de uso:
### Adicionar cliente novo:
- Para adicionar um cliente novo basta estar na tela de clientes(home)
- Para acessar a tela caso esteja em outra, basta clicar no ícone de pessoas incluído da barra de navegação em baixo da tela
- Após isto clicar no botão localizado no canto inferior direito da tela para ser redirecionado à tela de adiçãoa de cliente. Exemplo abaixo:
  ![image](https://github.com/user-attachments/assets/ea6b20ea-a5da-411a-a218-7b9b6e52e52a)
- **Todos os campos são obrigatórios**. Caso algum campo não esteja preenchido o app irá avisar para preencher como abaixo:
  ![image](https://github.com/user-attachments/assets/7da7a96e-971f-4c35-a674-816a168628f0)
- Após o preenchimento correto das informações e clicar no botão de salvar, se foi feito corretamente o salvamento você será redirecionado para a tela home:  
  ![image](https://github.com/user-attachments/assets/d8f80568-2cdc-4344-965e-5da083ab7a94)

### Adicionar endereço a um cliente:
- Na tela de clientes ao lado de cada registro de cliente é disponibilizado um menu de interação
- Clique no mesmo que será exibido as opções disponíveis:  
  ![image](https://github.com/user-attachments/assets/626519ed-db45-4b91-b86f-6a4c459d7823)
- Agora clique no item de endereços que será redirecionado para a página de endereço:
- Para mostrar os endereços do cliente, clique no botão com uma lupa para buscar:  
  ![image](https://github.com/user-attachments/assets/8b223c31-c5a6-4dde-a3db-198d1756b18c)
- Após clicar será buscado os endereços e exibido
- Clique no botão de adicionar endereço ou em cada registro há opções para manuseá-lo, no caso editar
- Será redirecionado para tela de cadastro de endereço:  
  ![image](https://github.com/user-attachments/assets/3ec05f7c-14bb-4071-ab5d-f89de7b7c876)
- **Todos os campos são obrigatórios**. Caso algum campo não esteja preenchido o app irá avisar para preencher como abaixo:
  ![image](https://github.com/user-attachments/assets/7df2b517-9c2f-4ef6-b395-12bc5d85bd58)
- Ao digitar o CEP o sistema automaticamente irá preencher os campos:  
  ![image](https://github.com/user-attachments/assets/e679540b-9103-4715-9300-bb397860b1b0)
- Após preenchimento correto e clicar no botão de salvar, se ocorreu tudo bem será exibido a mensagem de sucesso e redirecionado automáticamente para a tela de endereços:  
  ![image](https://github.com/user-attachments/assets/2ba7fd79-bab8-406f-b202-c11b13fd50f0)

### Deletar Cliente/Endereço:
- Para deletar um registro basta clicar no menu de interação do registro:  
  ![image](https://github.com/user-attachments/assets/cbfded68-2424-46be-9c1a-262ca53eb248)
- Clique na opção "Deletar"
- Ao clicar o app perguntará se deseja realmente deletar, caso clique em sim ele irá prosseguir com a exclusão:  
  ![image](https://github.com/user-attachments/assets/992b6c85-05f0-4ecd-8d33-0da0db0bc8cb)
- Se ocorreu tudo certo o app irá atualizar a lista de registros.
