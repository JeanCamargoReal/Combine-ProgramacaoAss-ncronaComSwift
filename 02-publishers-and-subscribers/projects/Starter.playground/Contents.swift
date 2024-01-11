import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    // 1
    // Valores, também chamados de elementos.
    let myNotification = Notification.Name("MyNotification")
    
    // 2
    // Um evento de conclusão.
    let publisher = NotificationCenter.default
        .publisher(for: myNotification, object: nil)
    
    // 3
    // Obtem um controle para o centro de notificação padrão.
    let center = NotificationCenter.default
    
    // 4
    // Cria um observador para ouvir a notificação com o nome que você criou anteriormente.
    let observer = center.addObserver(forName: myNotification,
                                      object: nil,
                                      queue: nil) { notification in
        print("Notification received!")
    }
    
    // 5
    // Posta uma notificação com esse nome.
    center.post(name: myNotification, object: nil)
    
    // 6
    // Remove o observador da central de notificações.
    center.removeObserver(observer)
}

// ------------------------------------------------------------------

example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    
    let publisher = center.publisher(for: myNotification, object: nil)
    
    // 1
    // Crie uma assinatura ligando sink ao publisher.
    let subscription = publisher
        .sink { _ in
            print("Notification received from a publisher!")
        }
    
    // 2
    // Posta a notificação.
    center.post(name: myNotification, object: nil)
    
    // 3
    // Cancele a assinatura.
    subscription.cancel()
}
