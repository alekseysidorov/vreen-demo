import QtQuick 2.0

ItemDelegate {
    property alias imageSource: image.source
    property alias imageWidth: image.width
    property alias imageHeight: image.height

    leftSideData: ShaderEffect {
        id: borderShader

        width: leftSideWidth
        height: width

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 2 * mm
        property variant source: ShaderEffectSource {
            sourceItem: Image {
                id: image

                fillMode: Image.PreserveAspectCrop
                clip: true

                width: Math.max(implicitWidth, implicitHeight)
                height: width
            }
            hideSource: true
        }

        property real radius: 0.8

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float radius;
            highp float radius2 = pow(0.707 * radius, 2.);
            uniform sampler2D source;
            float thickness = 0.08;
            void main(void)
            {
                highp vec4 texColor = texture2D(source, qt_TexCoord0.st);
                highp float x = abs(0.5 - qt_TexCoord0.x);
                highp float y = abs(0.5 - qt_TexCoord0.y);
                float distance2 = pow(x, 2.0) + pow(y, 2.0);

                if (distance2 > radius2) {
                    float factor = 1.0 - (distance2 - radius2) / thickness;
                    gl_FragColor = texColor * factor;
                } else {
                    gl_FragColor = texture2D(source, qt_TexCoord0);
                }
        }
        "
    }
}
