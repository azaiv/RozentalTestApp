import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        let vc = UINavigationController(rootViewController: DashboardViewController())
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }
}

//MainData(
//    myNewNotifications: 0,
//    customerDashboard: RozentalTestApp.CustomerDashboard(
//        date: "31 августа",
//        notifications: RozentalTestApp.Notifications(count: 0),
//        menuItems: [RozentalTestApp.MenuItem(action: "payment",
//                                             name: "Квартплата",
//                                             description: "Оплатить до 253",
//                                             arrear: Optional("16828.12"),
//                                             amountCoins: Optional(1682812), expected: nil),
//                    RozentalTestApp.MenuItem(
//                        action: "meters",
//                        name: "Показания счётчиков",
//                        description: "Отправить до 20 сентября",
//                        arrear: nil, amountCoins: nil,
//                        expected: Optional(RozentalTestApp.Expected(
//                            lastDate: "Отправьте новые показания до 20 сентября",
//                            indications: [
//                                RozentalTestApp.Indication(
//                                type: "water",
//                                label: "Водоснабжение",
//                                lastTransfer: "Внесите показания", expected: true), 
//                                RozentalTestApp.Indication(
//                                    type: "electricity",
//                                    label: "Электричество",
//                                    lastTransfer: "Внесите показания",
//                                    expected: true)])))],
//        banners: [
//            RozentalTestApp.Banner(
//            title: "Получай уведомления в Телеграм",
//            text: "Статусы обращений в телеграме!",
//            image: "https://storage.yandexcloud.net/rg-public/ico_for_banners/telegram-logo.png",
//            action: "https://t.me/rozentalgroup_bot?start=79241097731_9423_test-rozentalgroup-ru_4020779",
//            priority: 10), 
//            RozentalTestApp.Banner(title: "Всё о добровольном страховании квартиры",
//                                   text: "Ознакомиться с условиями",
//                                   image: "https://rozentalgroup.ru/user_dir/images/insurance.png",
//                                   action: "https://rozentalgroup.ru/new_site/build/documents/Информация о добровольном страховании",
//                                   priority: 10),
//            RozentalTestApp.Banner(
//                title: "Тех. поддержка приложения", 
//                text: "Что-то не получается? Мы поможем!",
//                image: "https://storage.yandexcloud.net/rg-public/ico_for_banners/support_ico.png",
//                action: "create_offer_development",
//                priority: 10),
//            RozentalTestApp.Banner(
//                title: "Наш Instagram",
//                text: "Следите за новостями",
//                image: "https://rozentalgroup.ru/user_dir/images/inst.png",
//                action: "https://www.instagram.com/rozentalgroup/?hl=ru",
//                priority: 10),
//            RozentalTestApp.Banner(
//                title: "Информация для собственников1111",
//                text: "Ответы на популярные вопросы, касающиеся работы мобильного приложения",
//                image: "https://test.rozentalgroup.ru/user_dir/images/information.png",
//                action: "https://test.rozentalgroup.ru/user_dir/images/answers.png",
//                priority: 10),
//            RozentalTestApp.Banner(
//                title: "Электронное голосование",
//                text: " Пошаговая инструкция",
//                image: "https://rozentalgroup.ru/user_dir/images/phone.png",
//                action: "https://www.instagram.com/p/CU7ObrMg313/", priority: 10),
//            RozentalTestApp.Banner(
//                title: "Яндекс.Дзен",
//                text: "Наши наблюдения в области ЖКХ",
//                image: "https://rozentalgroup.ru/user_dir/images/yndex.png",
//                action: "https://zen.yandex.ru/id/61483fb92cca05021690246e",
//                priority: 10)],
//        services: [
//            RozentalTestApp.Service(name: "Домофон", action: "intercom", order: 1),
//            RozentalTestApp.Service(name: "Камеры", action: "video", order: 1),
//            RozentalTestApp.Service(name: "Документы", action: "docs", order: 1),
//            RozentalTestApp.Service(name: "Предложения", action: "offer", order: 3),
//            RozentalTestApp.Service(name: "Опросы", action: "poll", order: 4),
//            RozentalTestApp.Service(name: "Качество уборки", action: "cleaning", order: 5),
//            RozentalTestApp.Service(name: "СКУД", action: "basip", order: 5),
//            RozentalTestApp.Service(name: "Голосования", action: "vote", order: 6),
//            RozentalTestApp.Service(name: "Заказать пропуск", action: "pass", order: 7)],
//        navbar: [
//            RozentalTestApp.NavbarItem(name: "Главная", action: "main"),
//            RozentalTestApp.NavbarItem(name: "Заявки", action: "treatment"),
//            RozentalTestApp.NavbarItem(name: "Легкий быт", action: "service"),
//            RozentalTestApp.NavbarItem(name: "Чат", action: "chat"),
//            RozentalTestApp.NavbarItem(name: "Контакты", action: "contact")]),
//myProfile: RozentalTestApp.MyProfile(
//    id: "9423",
//    name: "Алексеевский Алексей",
//    shortName: "Алексей А.",
//    firstName: "Алексей",
//    lastName: "Алексеевский",
//    secondName: "Алексеевич",
//    email: "", p
//    hone: "+7-924-109-77-31",
//    photo: "https://storage.yandexcloud.net/demo.rozentalgroup.ru/resize_cache/29880/f5f8029bd74508e3d8cb87e33f17fbbb/main/c67/c672896d3b4d3315fef6564a744f2599/task.png", property: "Доступно адресов: 12",
//    address: "Пилотов пер д 12, к.м. 10",
//    rating: 0), code: 200)
