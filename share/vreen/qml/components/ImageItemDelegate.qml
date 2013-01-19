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

        property real thickness: 0.05

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform float thickness;
            void main(void)
            {
                highp vec4 texColor = texture2D(source, qt_TexCoord0.st);
                highp float x = 0.5 - abs(0.5 - qt_TexCoord0.x);
                highp float y = 0.5 - abs(0.5 - qt_TexCoord0.y);
                float factor = 1.0;
                if (x < thickness) {
                    if (y > thickness)
                        factor = x / thickness;
                    else {
                        factor = (y / thickness) * (x / thickness);
                    }
                } else if (y < thickness)
                    factor = y / thickness;
                gl_FragColor = texColor * factor;
        }
        "
    }
}
