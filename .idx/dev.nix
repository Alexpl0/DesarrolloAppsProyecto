# Para aprender más sobre cómo usar Nix para configurar tu entorno
# visita: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }: {
  # Qué canal de nixpkgs usar.
  channel = "stable-24.05"; # o "unstable"

  # Usa https://search.nixos.org/packages para encontrar paquetes
  packages = [
    # Agregamos el SDK de Flutter para que esté disponible en el entorno
    pkgs.flutter
    # --- SOLUCIÓN ---
    # Se añade el JDK (Java Development Kit) a los paquetes del entorno.
    # Gradle lo necesita para compilar la app de Android.
    pkgs.jdk17
  ];

  # Establece variables de entorno en el espacio de trabajo
  env = {
    # --- SOLUCIÓN ---
    # Se establece la variable de entorno JAVA_HOME para que apunte
    # a la ubicación del JDK que acabamos de instalar.
    JAVA_HOME = "${pkgs.jdk17}/";
  };
  
  idx = {
    # Busca las extensiones que quieras en https://open-vsx.org/ y usa "publisher.id"
    extensions = [
      "dart-code.flutter"
      "dart-code.dart-code"
    ];

    # Habilitar vistas previas
    previews = {
      enable = true;
      previews = {
        # Configuración para el emulador de Android.
        android = {
          manager = "android";
        };
        
        # Vista previa web - Usando web-server para IDX (no requiere Chrome)
        web = {
          command = ["flutter" "run" "-d" "web-server" "--web-port" "$PORT"];
          manager = "web";
        };
      };
    };

    # Hooks del ciclo de vida del espacio de trabajo
    workspace = {
      # Se ejecuta cuando se crea un espacio de trabajo por primera vez
      onCreate = {
        get-flutter-deps = "flutter pub get";
      };
      # Se ejecuta cuando el espacio de trabajo se (re)inicia
      onStart = {};
    };
  };
}
