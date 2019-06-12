module ApplicationMailer
  module_function

  def self.notify_user_about_neighbour(user)
    from = {
        'Email' => 'tcc.neighbourhood@gmail.com',
        'Name' => 'Boa noite, vizinhanca!'
    }
    to = [
        {
            'Email' => user.email,
            'Name' => user.name
        }
    ]
    subject = "Relatorio sobre a criminalidade no bairro #{user.neighbour.name} no mes de #{translate_month(Time.now.month)}/#{Time.now.year}"
    report_text = [
        "Furtos: #{user.neighbour.occurrences.thefts.count}",
        "Roubos: #{user.neighbour.occurrences.robberies.count}",
        "Apreensões de droga: #{user.neighbour.occurrences.traffics.count}",
        "Estupros: #{user.neighbour.occurrences.rapes.count}",
        "Agressões: #{user.neighbour.occurrences.assaults.count}",
        "Índice de criminalidade: #{user.neighbour.criminality_index.round(2).to_s}"
    ].join(". ")

    unsubscribe_text = "Caso não queira mais receber os informes mensais, clique <a href='https://neighbourhoodtcc.herokuapp.com/users/#{user.id}/unsubscribe'>aqui</a> para se descadastrar."

    text = [report_text, unsubscribe_text].join("<br><br><br><br>")
    message = {
        'From' => from,
        'To' => to,
        'Subject' => subject,
        'HtmlPart' => text
    }

    Mailjet::Send.create(messages: [message])
  end

  def self.translate_month(month)
    %w[janeiro fevereiro março
       abril maio junho
       julho agosto setembro
       outubro novembro dezembro][month - 1]
  end
end
