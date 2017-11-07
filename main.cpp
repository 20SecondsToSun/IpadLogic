#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMediaPlayer>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}



//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
//#include <QMediaPlayer>
//#include <QVideoWidget>
//#include <QApplication>

//int main(int argc, char *argv[])
//{
//    QApplication app(argc, argv);

////    QQmlApplicationEngine engine;
////    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
////    if (engine.rootObjects().isEmpty())
////        return -1;

//    QMediaPlayer* player = new QMediaPlayer();
//    QVideoWidget* vw = new QVideoWidget;

//    player->setVideoOutput(vw);
//    player->setMedia((QUrl("qrc:/images/design/SampleVideo_1280x720_1mb.mp4")));


//    vw->setGeometry(0, 0, 1024, 768);
//    vw->show();

//    player->play();


//    return app.exec();
//}
