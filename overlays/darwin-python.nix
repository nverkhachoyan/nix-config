_: prev: {
  python313Packages = prev.python313Packages.overrideScope (
    _: pyPrev: {
      # yt-dlp deps pull jeepney, and it fails on Darwin (jeepney uses dbus, which is not available on Darwin)
      # Disabling D-Bus check for jeepney for now
      jeepney = pyPrev.jeepney.overridePythonAttrs (_: {
        doCheck = false;
        pythonImportsCheck = [ ];
      });
    }
  );
}
