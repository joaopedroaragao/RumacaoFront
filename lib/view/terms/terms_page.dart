import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/action_button.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  // Exemplo de texto fixo para os Termos e Condições
  static const String _termsText = '''
Bem-vindo ao Arrumação!

Estes Termos e Condições descrevem as regras e regulamentos para a utilização do nosso aplicativo. 
Ao acessá-lo, você aceita e concorda em cumprir todos os termos descritos abaixo.

1. Uso do Aplicativo
   • Você deve utilizar o aplicativo de maneira responsável e respeitosa, 
     não violando qualquer lei ou direito de terceiros.
   • É proibido reproduzir, duplicar, copiar, vender ou explorar comercialmente 
     qualquer parte do aplicativo sem permissão prévia por escrito.

2. Responsabilidades
   • O Arrumação se reserva o direito de atualizar ou modificar o aplicativo a 
     qualquer momento, sem aviso prévio.
   • Não garantimos que o aplicativo estará sempre disponível, livre de falhas 
     ou erros.

3. Privacidade
   • Quaisquer dados coletados serão tratados de acordo com nossa Política de Privacidade.

4. Aceitação dos Termos
   • Ao continuar utilizando o aplicativo, você reconhece ter lido, compreendido 
     e concordado com todos os termos e condições aqui estabelecidos.

Se você não concorda com qualquer parte destes Termos e Condições, não utilize o aplicativo.

Obrigado por usar o Arrumação!
''';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Aparência do fundo do diálogo
      backgroundColor: Colors.white,
      // Define o espaçamento das bordas do diálogo em relação à tela
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 300,
        height: 400, // Ajuste conforme necessário
        child: Column(
          children: [
            // Título e botão de fechar
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TERMOS E CONDIÇÕES',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Área cinza com rolagem para o texto de termos
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _termsText,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botão laranja (ActionButton)
            ActionButton(
              text: 'ACEITAR',
              onPressed: () {
                // Lógica ao aceitar os termos
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
