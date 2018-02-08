# functions to automatically initialize some of YACReader's build options to
# default values if they're not set on build time
# for a more detailed description, see INSTALL.TXT

# check Qt version
QT_VERSION = $$[QT_VERSION]
QT_VERSION = $$split(QT_VERSION, ".")
QT_VER_MAJ = $$member(QT_VERSION, 0)
QT_VER_MIN = $$member(QT_VERSION, 1)

lessThan(QT_VER_MAJ, 5) {
error(YACReader requires Qt 5 or newer but Qt $$[QT_VERSION] was detected.)
  }
lessThan(QT_VER_MIN, 6) {
  warning ("Qt < 5.6 detected. Compilation will probably work, but some qml based components in YACReaderLibrary (GridView, InfoView) will fail at runtime.")
  }
lessThan(QT_VER_MIN, 4):!CONFIG(no_opengl) {
  CONFIG += legacy_gl_widget
  warning ("Qt < 5.4 detected. Using QGLWidget for coverflow.")
  warning ("QGLWidget based coverflow is scheduled for removal.")
  }
lessThan(QT_VER_MIN, 3) {
  error ("You need at least Qt 5.3 to compile YACReader or YACReaderLibrary.")
  }

#build without opengl widget support
CONFIG(no_opengl) {
  DEFINES += NO_OPENGL
}

# default value for comic archive decompression backend
!CONFIG(unarr):!CONFIG(7zip) {
  CONFIG += unarr
}

# default values for pdf render backend
win32:!CONFIG(poppler):!CONFIG(pdfium):!CONFIG(no_pdf) {
  CONFIG += pdfium
}

unix:!macx:!CONFIG(poppler):!CONFIG(pdfium):!CONFIG(no_pdf) {
  CONFIG += poppler
}

macx:!CONFIG(pdfkit):!CONFIG(pdfium):!CONFIG(no_pdf) {
  CONFIG += pdfium
}