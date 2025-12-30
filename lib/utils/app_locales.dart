import 'package:flutter_localization/flutter_localization.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

mixin AppLocale {
  // Bottom Navigation Bar
  static const String home = 'home';
  static const String clients = 'clients';
  static const String invoices = 'invoices';
  static const String reports = 'reports';

  // Onboarding
  static const String onboardingTitle1 = 'onboardingTitle1';
  static const String onboardingDesc1 = 'onboardingDesc1';
  static const String onboardingTitle2 = 'onboardingTitle2';
  static const String onboardingDesc2 = 'onboardingDesc2';
  static const String onboardingTitle3 = 'onboardingTitle3';
  static const String onboardingDesc3 = 'onboardingDesc3';
  static const String getStarted = 'getStarted';
  static const String next = 'next';
  static const String skip = 'skip';

  // Login
  static const String welcomeBack = 'welcomeBack';
  static const String logInToManage = 'logInToManage';
  static const String emailAddress = 'emailAddress';
  static const String password = 'password';
  static const String forgotPassword = 'forgotPassword';
  static const String logIn = 'logIn';
  static const String dontHaveAccount = 'dontHaveAccount';
  static const String signUp = 'signUp';

  // Register
  static const String createAccount = 'createAccount';
  static const String startSendingInvoices = 'startSendingInvoices';
  static const String fullName = 'fullName';
  static const String iAgreeTo = 'iAgreeTo';
  static const String termsOfService = 'termsOfService';
  static const String and = 'and';
  static const String privacyPolicy = 'privacyPolicy';
  static const String createAccountBtn = 'createAccountBtn';
  static const String alreadyHaveAccount = 'alreadyHaveAccount';

  // Forgot Password
  static const String resetPassword = 'resetPassword';
  static const String resetDesc = 'resetDesc';
  static const String sendResetLink = 'sendResetLink';

  // Company Setup
  static const String setUpProfile = 'setUpProfile';
  static const String companyDetailsDesc = 'companyDetailsDesc';
  static const String tapToUploadLogo = 'tapToUploadLogo';
  static const String companyName = 'companyName';
  static const String businessEmail = 'businessEmail';
  static const String phoneNumber = 'phoneNumber';
  static const String address = 'address';
  static const String defaultCurrency = 'defaultCurrency';
  static const String nextStep = 'nextStep';

  // Template Setup
  static const String customizeYourLook = 'customizeYourLook';
  static const String chooseColorAndFont = 'chooseColorAndFont';
  static const String primaryColor = 'primaryColor';
  static const String typography = 'typography';
  static const String finishSetup = 'finishSetup';

  // Dashboard
  static const String dashboard = 'dashboard';
  static const String heresYourOverview = 'heresYourOverview';
  static const String totalRevenue = 'totalRevenue';
  static const String outstanding = 'outstanding';
  static const String overdue = 'overdue';
  static const String recentActivity = 'recentActivity';
  static const String seeAll = 'seeAll';
  static const String noInvoices = 'noInvoices';
  static const String createFirstInvoice = 'createFirstInvoice';

  // Client Detail
  static const String clientDetails = 'clientDetails';
  static const String open = 'open';
  static const String paid = 'paid';
  static const String projects = 'projects';
  static const String allCaughtUp = 'allCaughtUp';
  static const String call = 'call';
  static const String email = 'email';
  static const String website = 'website';
  static const String create = 'create';
  static const String clientNotes = 'clientNotes';
  static const String noNotesYet = 'noNotesYet';
  static const String cancel = 'cancel';
  static const String saveNotes = 'saveNotes';
  static const String pleaseWait = 'pleaseWait';

  // Clients List
  static const String noClientsFound = 'noClientsFound';
  static const String tapToAddClient = 'tapToAddClient';
  static const String newClient = 'newClient';
  static const String addClientDetails = 'addClientDetails';
  static const String contactName = 'contactName';
  static const String companyWebsite = 'companyWebsite';
  static const String selectIndustry = 'selectIndustry';
  static const String addClient = 'addClient';

  // New Invoice
  static const String newInvoice = 'newInvoice';
  static const String professionalInvoices = 'professionalInvoices';
  static const String preview = 'preview';
  static const String client = 'client';
  static const String selectAClient = 'selectAClient';
  static const String dates = 'dates';
  static const String issued = 'issued';
  static const String due = 'due';
  static const String useDefaultCurrency = 'useDefaultCurrency';
  static const String lineItems = 'lineItems';
  static const String addItem = 'addItem';
  static const String itemDescription = 'itemDescription';
  static const String qty = 'qty';
  static const String rate = 'rate';
  static const String amount = 'amount';
  static const String taxPercent = 'taxPercent';
  static const String discountPercent = 'discountPercent';
  static const String acceptPaymentWithInvoice = 'acceptPaymentWithInvoice';
  static const String includePaymentInstructions = 'includePaymentInstructions';
  static const String paymentMethod = 'paymentMethod';
  static const String bankAccountDetails = 'bankAccountDetails';
  static const String paypalEmail = 'paypalEmail';
  static const String stripeLink = 'stripeLink';
  static const String upiId = 'upiId';
  static const String subtotal = 'subtotal';
  static const String totalDue = 'totalDue';
  static const String generateAndSend = 'generateAndSend';
  static const String updateInvoice = 'updateInvoice';

  // Invoice Detail
  static const String invoiceDetails = 'invoiceDetails';
  static const String remind = 'remind';
  static const String recordPayment = 'recordPayment';
  static const String resendInvoice = 'resendInvoice';
  static const String billedTo = 'billedTo';
  static const String paymentMethodLabel = 'paymentMethodLabel';
  static const String items = 'items';
  static const String activity = 'activity';

  // Invoice Preview
  static const String invoicePreview = 'invoicePreview';

  // Settings
  static const String settings = 'settings';
  static const String monthlyRevenueGoal = 'monthlyRevenueGoal';
  static const String upgradeToPro = 'upgradeToPro';
  static const String privacyAndSecurity = 'privacyAndSecurity';
  static const String helpAndSupport = 'helpAndSupport';
  static const String checkForUpdates = 'checkForUpdates';
  static const String logOut = 'logOut';
  static const String deleteAccount = 'deleteAccount';

  // Reports
  static const String financialOverview = 'financialOverview';
  static const String revenueTrend = 'revenueTrend';
  static const String topClients = 'topClients';
  static const String noRevenueData = 'noRevenueData';
  static const String noClientData = 'noClientData';

  // Messages (Success & Error)
  static const String pleaseEnterValidEmail = 'pleaseEnterValidEmail';
  static const String pleaseFillAllFields = 'pleaseFillAllFields';
  static const String accountCreatedSuccess = 'accountCreatedSuccess';
  static const String invalidEmail = 'invalidEmail';
  static const String passwordTooShort = 'passwordTooShort';
  static const String acceptTerms = 'acceptTerms';
  static const String allFieldsRequired = 'allFieldsRequired';
  static const String invoiceCreated = 'invoiceCreated';
  static const String invoiceUpdated = 'invoiceUpdated';
  static const String invoiceDeleted = 'invoiceDeleted';
  static const String invoiceSent = 'invoiceSent';
  static const String paymentRecorded = 'paymentRecorded';

  // General
  static const String appName = 'appName';

  static const Map<String, dynamic> EN = {
    // Bottom Nav
    home: "Home",
    clients: "Clients",
    invoices: "Invoices",
    reports: "Reports",

    // Onboarding
    onboardingTitle1: "Send Invoices in Seconds",
    onboardingDesc1:
        "Create professional invoices with your logo and branding — no spreadsheets needed.",
    onboardingTitle2: "Get Paid Faster",
    onboardingDesc2:
        "Track payments, send smart reminders, and see who owes you at a glance.",
    onboardingTitle3: "Work Like a Pro",
    onboardingDesc3:
        "Partial payments, late fees, client notes, and beautiful reports — all in one place.",
    getStarted: "Get Started",
    next: "Next",
    skip: "Skip",

    // Login
    welcomeBack: "Welcome Back",
    logInToManage: "Log in to manage your invoices",
    emailAddress: "Email Address",
    password: "Password",
    forgotPassword: "Forgot Password?",
    logIn: "Log In",
    dontHaveAccount: "Don't have an account? ",
    signUp: "Sign Up",

    // Register
    createAccount: "Create Account",
    startSendingInvoices: "Start sending invoices and getting paid faster",
    fullName: "Full Name",
    iAgreeTo: "I agree to the ",
    termsOfService: "Terms of Service",
    and: "and",
    privacyPolicy: "Privacy Policy",
    createAccountBtn: "Create Account",
    alreadyHaveAccount: "Already have an account? ",

    // Forgot Password
    resetPassword: "Reset Password",
    resetDesc:
        "Enter your email and we'll send you a link to reset your password",
    sendResetLink: "Send Reset Link",

    // Company Setup
    setUpProfile: "Set up your profile",
    companyDetailsDesc:
        "Add your company details to look professional on your invoices.",
    tapToUploadLogo: "Tap to upload logo",
    companyName: "Company Name",
    businessEmail: "Business Email",
    phoneNumber: "Phone Number",
    address: "Address",
    defaultCurrency: "Default Currency",
    nextStep: "Next Step →",

    // Template Setup
    customizeYourLook: "Customize your look",
    chooseColorAndFont: "Choose a color and font for your invoice templates.",
    primaryColor: "PRIMARY COLOR",
    typography: "TYPOGRAPHY",
    finishSetup: "Finish Setup →",

    // Dashboard
    dashboard: "Dashboard",
    heresYourOverview: "Here's your overview",
    totalRevenue: "Total Revenue",
    outstanding: "Outstanding",
    overdue: "Overdue",
    recentActivity: "Recent Activity",
    seeAll: "See All",
    noInvoices: "No invoices",
    createFirstInvoice: "Create your first invoice to get started",

    // Client Detail
    clientDetails: "Client Details",
    open: "Open",
    paid: "Paid",
    projects: "Projects",
    allCaughtUp: "All caught up",
    call: "Call",
    email: "Email",
    website: "Website",
    create: "Create",
    clientNotes: "Client Notes",
    noNotesYet: "No notes yet. Tap right icon to add.",
    cancel: "Cancel",
    saveNotes: "Save Notes",
    pleaseWait: "Please wait...",

    // Clients List
    noClientsFound: "No clients found",
    tapToAddClient: "Tap + to add your first client",
    newClient: "New Client",
    addClientDetails: "Add client details to start invoicing",
    contactName: "Contact Name",
    companyWebsite: "Company Website",
    selectIndustry: "Select Industry",
    addClient: "Add Client",

    // New Invoice
    newInvoice: "New Invoice",
    professionalInvoices: "Professional invoices in seconds",
    preview: "Preview",
    client: "Client",
    selectAClient: "Select a client",
    dates: "Dates",
    issued: "Issued",
    due: "Due",
    useDefaultCurrency: "Use Default Currency",
    lineItems: "Line Items",
    addItem: "Add Item",
    itemDescription: "Item Description",
    qty: "Qty",
    rate: "Rate",
    amount: "Amount",
    taxPercent: "Tax %",
    discountPercent: "Discount %",
    acceptPaymentWithInvoice: "Accept Payment with Invoice",
    includePaymentInstructions: "Include payment instructions",
    paymentMethod: "Payment Method",
    bankAccountDetails: "Bank Account Details",
    paypalEmail: "PayPal Email",
    stripeLink: "Stripe Account / Payment Link",
    upiId: "UPI ID",
    subtotal: "Subtotal",
    totalDue: "Total Due",
    generateAndSend: "Generate & Send",
    updateInvoice: "Update Invoice",

    // Invoice Detail
    invoiceDetails: "Invoice Details",
    remind: "Remind",
    recordPayment: "Record Payment",
    resendInvoice: "Resend Invoice",
    billedTo: "BILLED TO",
    paymentMethodLabel: "PAYMENT METHOD",
    items: "Items",
    activity: "Activity",

    // Invoice Preview
    invoicePreview: "Invoice Preview",

    // Settings
    settings: "Settings",
    monthlyRevenueGoal: "Monthly Revenue Goal",
    upgradeToPro: "Upgrade to Pro",
    privacyAndSecurity: "Privacy & Security",
    helpAndSupport: "Help & Support",
    checkForUpdates: "Check for Updates",
    logOut: "Log Out",
    deleteAccount: "Delete Account",

    // Reports
    financialOverview: "Financial Overview",
    revenueTrend: "Revenue Trend",
    topClients: "Top Clients",
    noRevenueData: "No revenue data",
    noClientData: "No client data yet",

    // Messages
    pleaseEnterValidEmail: "Please enter a valid email",
    pleaseFillAllFields: "Please fill all fields",
    accountCreatedSuccess: "Account created successfully!",
    invalidEmail: "Invalid email address",
    passwordTooShort: "Password must be at least 6 characters",
    acceptTerms: "Please accept terms and privacy policy",
    allFieldsRequired: "All fields are required",
    invoiceCreated: "Invoice created!",
    invoiceUpdated: "Invoice updated!",
    invoiceDeleted: "Invoice deleted",
    invoiceSent: "Invoice sent successfully!",
    paymentRecorded: "Payment of {amount} recorded!",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> ES = {
    home: "Inicio",
    clients: "Clientes",
    invoices: "Facturas",
    reports: "Informes",

    onboardingTitle1: "Envía Facturas en Segundos",
    onboardingDesc1:
        "Crea facturas profesionales con tu logo y marca — sin hojas de cálculo.",
    onboardingTitle2: "Cobra Más Rápido",
    onboardingDesc2:
        "Seguimiento de pagos, recordatorios inteligentes y vista clara de deudas.",
    onboardingTitle3: "Trabaja Como Profesional",
    onboardingDesc3:
        "Pagos parciales, recargos, notas de cliente e informes hermosos — todo en un lugar.",
    getStarted: "Comenzar",
    next: "Siguiente",
    skip: "Omitir",

    welcomeBack: "Bienvenido de Nuevo",
    logInToManage: "Inicia sesión para gestionar tus facturas",
    emailAddress: "Correo Electrónico",
    password: "Contraseña",
    forgotPassword: "¿Olvidaste tu contraseña?",
    logIn: "Iniciar Sesión",
    dontHaveAccount: "¿No tienes cuenta? ",
    signUp: "Registrarse",

    createAccount: "Crear Cuenta",
    startSendingInvoices: "Empieza a enviar facturas y cobra más rápido",
    fullName: "Nombre Completo",
    iAgreeTo: "Acepto los ",
    termsOfService: "Términos de Servicio",
    and: "y la",
    privacyPolicy: "Política de Privacidad",
    createAccountBtn: "Crear Cuenta",
    alreadyHaveAccount: "¿Ya tienes cuenta? ",

    resetPassword: "Restablecer Contraseña",
    resetDesc: "Ingresa tu correo y te enviaremos un enlace para restablecerla",
    sendResetLink: "Enviar Enlace",

    setUpProfile: "Configura tu perfil",
    companyDetailsDesc:
        "Agrega los detalles de tu empresa para lucir profesional en tus facturas.",
    tapToUploadLogo: "Toca para subir logo",
    companyName: "Nombre de la Empresa",
    businessEmail: "Correo Empresarial",
    phoneNumber: "Número de Teléfono",
    address: "Dirección",
    defaultCurrency: "Moneda Predeterminada",
    nextStep: "Siguiente Paso →",

    customizeYourLook: "Personaliza tu estilo",
    chooseColorAndFont:
        "Elige un color y fuente para tus plantillas de factura.",
    primaryColor: "COLOR PRINCIPAL",
    typography: "TIPOGRAFÍA",
    finishSetup: "Finalizar Configuración →",

    dashboard: "Panel",
    heresYourOverview: "Aquí tienes tu resumen",
    totalRevenue: "Ingresos Totales",
    outstanding: "Pendiente",
    overdue: "Vencido",
    recentActivity: "Actividad Reciente",
    seeAll: "Ver Todo",
    noInvoices: "Sin facturas",
    createFirstInvoice: "Crea tu primera factura para comenzar",

    clientDetails: "Detalles del Cliente",
    open: "Abiertas",
    paid: "Pagadas",
    projects: "Proyectos",
    allCaughtUp: "Todo al día",
    call: "Llamar",
    email: "Correo",
    website: "Sitio Web",
    create: "Crear",
    clientNotes: "Notas del Cliente",
    noNotesYet: "Sin notas aún. Toca el ícono derecho para agregar.",
    cancel: "Cancelar",
    saveNotes: "Guardar Notas",
    pleaseWait: "Por favor espera...",

    noClientsFound: "No se encontraron clientes",
    tapToAddClient: "Toca + para agregar tu primer cliente",
    newClient: "Nuevo Cliente",
    addClientDetails: "Agrega detalles del cliente para comenzar a facturar",
    contactName: "Nombre de Contacto",
    companyWebsite: "Sitio Web de la Empresa",
    selectIndustry: "Seleccionar Industria",
    addClient: "Agregar Cliente",

    newInvoice: "Nueva Factura",
    professionalInvoices: "Facturas profesionales en segundos",
    preview: "Vista Previa",
    client: "Cliente",
    selectAClient: "Seleccionar un cliente",
    dates: "Fechas",
    issued: "Emitida",
    due: "Vencimiento",
    useDefaultCurrency: "Usar Moneda Predeterminada",
    lineItems: "Ítems",
    addItem: "Agregar Ítem",
    itemDescription: "Descripción del Ítem",
    qty: "Cant.",
    rate: "Tarifa",
    amount: "Monto",
    taxPercent: "Impuesto %",
    discountPercent: "Descuento %",
    acceptPaymentWithInvoice: "Aceptar Pago con Factura",
    includePaymentInstructions: "Incluir instrucciones de pago",
    paymentMethod: "Método de Pago",
    bankAccountDetails: "Detalles de Cuenta Bancaria",
    paypalEmail: "Correo PayPal",
    stripeLink: "Cuenta Stripe / Enlace de Pago",
    upiId: "ID UPI",
    subtotal: "Subtotal",
    totalDue: "Total Pendiente",
    generateAndSend: "Generar y Enviar",
    updateInvoice: "Actualizar Factura",

    invoiceDetails: "Detalles de Factura",
    remind: "Recordar",
    recordPayment: "Registrar Pago",
    resendInvoice: "Reenviar Factura",
    billedTo: "FACTURADO A",
    paymentMethodLabel: "MÉTODO DE PAGO",
    items: "Ítems",
    activity: "Actividad",

    invoicePreview: "Vista Previa de Factura",

    settings: "Configuración",
    monthlyRevenueGoal: "Meta de Ingresos Mensuales",
    upgradeToPro: "Actualizar a Pro",
    privacyAndSecurity: "Privacidad y Seguridad",
    helpAndSupport: "Ayuda y Soporte",
    checkForUpdates: "Buscar Actualizaciones",
    logOut: "Cerrar Sesión",
    deleteAccount: "Eliminar Cuenta",

    financialOverview: "Resumen Financiero",
    revenueTrend: "Tendencia de Ingresos",
    topClients: "Clientes Principales",
    noRevenueData: "Sin datos de ingresos",
    noClientData: "Sin datos de clientes aún",

    pleaseEnterValidEmail: "Por favor ingresa un correo válido",
    pleaseFillAllFields: "Por favor completa todos los campos",
    accountCreatedSuccess: "¡Cuenta creada exitosamente!",
    invalidEmail: "Correo electrónico inválido",
    passwordTooShort: "La contraseña debe tener al menos 6 caracteres",
    acceptTerms: "Por favor acepta los términos y la política de privacidad",
    allFieldsRequired: "Todos los campos son requeridos",
    invoiceCreated: "¡Factura creada!",
    invoiceUpdated: "¡Factura actualizada!",
    invoiceDeleted: "Factura eliminada",
    invoiceSent: "¡Factura enviada exitosamente!",
    paymentRecorded: "¡Pago de {amount} registrado!",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> PT = {
    // Bottom Nav
    home: "Início",
    clients: "Clientes",
    invoices: "Faturas",
    reports: "Relatórios",

    // Onboarding
    onboardingTitle1: "Envie Faturas em Segundos",
    onboardingDesc1:
        "Crie faturas profissionais com seu logo e marca — sem planilhas necessárias.",
    onboardingTitle2: "Receba Pagamentos Mais Rápido",
    onboardingDesc2:
        "Acompanhe pagamentos, envie lembretes inteligentes e veja quem lhe deve de relance.",
    onboardingTitle3: "Trabalhe Como Profissional",
    onboardingDesc3:
        "Pagamentos parciais, multas por atraso, notas de cliente e relatórios bonitos — tudo em um lugar.",
    getStarted: "Começar",
    next: "Próximo",
    skip: "Pular",

    // Login
    welcomeBack: "Bem-vindo de Volta",
    logInToManage: "Faça login para gerenciar suas faturas",
    emailAddress: "Endereço de Email",
    password: "Senha",
    forgotPassword: "Esqueceu a Senha?",
    logIn: "Entrar",
    dontHaveAccount: "Não tem conta? ",
    signUp: "Cadastrar",

    // Register
    createAccount: "Criar Conta",
    startSendingInvoices:
        "Comece a enviar faturas e receba pagamentos mais rápido",
    fullName: "Nome Completo",
    iAgreeTo: "Eu concordo com os ",
    termsOfService: "Termos de Serviço",
    and: "e",
    privacyPolicy: "Política de Privacidade",
    createAccountBtn: "Criar Conta",
    alreadyHaveAccount: "Já tem conta? ",

    // Forgot Password
    resetPassword: "Redefinir Senha",
    resetDesc: "Digite seu email e enviaremos um link para redefinir sua senha",
    sendResetLink: "Enviar Link de Redefinição",

    // Company Setup
    setUpProfile: "Configure seu perfil",
    companyDetailsDesc:
        "Adicione os detalhes da sua empresa para parecer profissional em suas faturas.",
    tapToUploadLogo: "Toque para enviar logo",
    companyName: "Nome da Empresa",
    businessEmail: "Email Comercial",
    phoneNumber: "Número de Telefone",
    address: "Endereço",
    defaultCurrency: "Moeda Padrão",
    nextStep: "Próximo Passo →",

    // Template Setup
    customizeYourLook: "Personalize sua aparência",
    chooseColorAndFont: "Escolha uma cor e fonte para seus modelos de fatura.",
    primaryColor: "COR PRIMÁRIA",
    typography: "TIPOGRAFIA",
    finishSetup: "Finalizar Configuração →",

    // Dashboard
    dashboard: "Painel",
    heresYourOverview: "Aqui está seu resumo",
    totalRevenue: "Receita Total",
    outstanding: "Pendentes",
    overdue: "Vencidas",
    recentActivity: "Atividade Recente",
    seeAll: "Ver Tudo",
    noInvoices: "Sem faturas",
    createFirstInvoice: "Crie sua primeira fatura para começar",

    // Client Detail
    clientDetails: "Detalhes do Cliente",
    open: "Abertas",
    paid: "Pagas",
    projects: "Projetos",
    allCaughtUp: "Tudo em dia",
    call: "Ligar",
    email: "Email",
    website: "Site",
    create: "Criar",
    clientNotes: "Notas do Cliente",
    noNotesYet: "Sem notas ainda. Toque no ícone direito para adicionar.",
    cancel: "Cancelar",
    saveNotes: "Salvar Notas",
    pleaseWait: "Por favor aguarde...",

    // Clients List
    noClientsFound: "Nenhum cliente encontrado",
    tapToAddClient: "Toque + para adicionar seu primeiro cliente",
    newClient: "Novo Cliente",
    addClientDetails: "Adicione detalhes do cliente para começar a faturar",
    contactName: "Nome de Contato",
    companyWebsite: "Site da Empresa",
    selectIndustry: "Selecionar Setor",
    addClient: "Adicionar Cliente",

    // New Invoice
    newInvoice: "Nova Fatura",
    professionalInvoices: "Faturas profissionais em segundos",
    preview: "Visualizar",
    client: "Cliente",
    selectAClient: "Selecionar um cliente",
    dates: "Datas",
    issued: "Emitida",
    due: "Vencimento",
    useDefaultCurrency: "Usar Moeda Padrão",
    lineItems: "Itens",
    addItem: "Adicionar Item",
    itemDescription: "Descrição do Item",
    qty: "Qtd",
    rate: "Valor Unitário",
    amount: "Total",
    taxPercent: "Imposto %",
    discountPercent: "Desconto %",
    acceptPaymentWithInvoice: "Aceitar Pagamento com Fatura",
    includePaymentInstructions: "Incluir instruções de pagamento",
    paymentMethod: "Método de Pagamento",
    bankAccountDetails: "Detalhes da Conta Bancária",
    paypalEmail: "Email PayPal",
    stripeLink: "Conta Stripe / Link de Pagamento",
    upiId: "ID UPI",
    subtotal: "Subtotal",
    totalDue: "Total Devido",
    generateAndSend: "Gerar e Enviar",
    updateInvoice: "Atualizar Fatura",

    // Invoice Detail
    invoiceDetails: "Detalhes da Fatura",
    remind: "Lembrar",
    recordPayment: "Registrar Pagamento",
    resendInvoice: "Reenviar Fatura",
    billedTo: "FATURADO PARA",
    paymentMethodLabel: "MÉTODO DE PAGAMENTO",
    items: "Itens",
    activity: "Atividade",

    // Invoice Preview
    invoicePreview: "Visualização da Fatura",

    // Settings
    settings: "Configurações",
    monthlyRevenueGoal: "Meta de Receita Mensal",
    upgradeToPro: "Atualizar para Pro",
    privacyAndSecurity: "Privacidade e Segurança",
    helpAndSupport: "Ajuda e Suporte",
    checkForUpdates: "Verificar Atualizações",
    logOut: "Sair",
    deleteAccount: "Excluir Conta",

    // Reports
    financialOverview: "Resumo Financeiro",
    revenueTrend: "Tendência de Receita",
    topClients: "Principais Clientes",
    noRevenueData: "Sem dados de receita",
    noClientData: "Sem dados de clientes ainda",

    // Messages
    pleaseEnterValidEmail: "Por favor, insira um email válido",
    pleaseFillAllFields: "Por favor, preencha todos os campos",
    accountCreatedSuccess: "Conta criada com sucesso!",
    invalidEmail: "Endereço de email inválido",
    passwordTooShort: "A senha deve ter pelo menos 6 caracteres",
    acceptTerms: "Por favor, aceite os termos e a política de privacidade",
    allFieldsRequired: "Todos os campos são obrigatórios",
    invoiceCreated: "Fatura criada!",
    invoiceUpdated: "Fatura atualizada!",
    invoiceDeleted: "Fatura excluída",
    invoiceSent: "Fatura enviada com sucesso!",
    paymentRecorded: "Pagamento de {amount} registrado!",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> HI = {
    // Bottom Nav
    home: "होम",
    clients: "क्लाइंट",
    invoices: "इनवॉइस",
    reports: "रिपोर्ट",

    // Onboarding
    onboardingTitle1: "सेकंड में इनवॉइस भेजें",
    onboardingDesc1:
        "अपने लोगो और ब्रांडिंग के साथ प्रोफेशनल इनवॉइस बनाएं — स्प्रेडशीट की जरूरत नहीं।",
    onboardingTitle2: "तेजी से भुगतान प्राप्त करें",
    onboardingDesc2:
        "भुगतान ट्रैक करें, स्मार्ट रिमाइंडर भेजें, और एक नजर में देखें कि कौन बकाया है।",
    onboardingTitle3: "प्रो की तरह काम करें",
    onboardingDesc3:
        "आंशिक भुगतान, देर से शुल्क, क्लाइंट नोट्स, और सुंदर रिपोर्ट — सब एक जगह पर।",
    getStarted: "शुरू करें",
    next: "अगला",
    skip: "स्किप",

    // Login
    welcomeBack: "वापस स्वागत है",
    logInToManage: "अपने इनवॉइस प्रबंधित करने के लिए लॉग इन करें",
    emailAddress: "ईमेल पता",
    password: "पासवर्ड",
    forgotPassword: "पासवर्ड भूल गए?",
    logIn: "लॉग इन",
    dontHaveAccount: "खाता नहीं है? ",
    signUp: "साइन अप",

    // Register
    createAccount: "खाता बनाएं",
    startSendingInvoices:
        "इनवॉइस भेजना शुरू करें और तेजी से भुगतान प्राप्त करें",
    fullName: "पूरा नाम",
    iAgreeTo: "मैं सहमत हूं ",
    termsOfService: "सेवा की शर्तों",
    and: "और",
    privacyPolicy: "गोपनीयता नीति",
    createAccountBtn: "खाता बनाएं",
    alreadyHaveAccount: "पहले से खाता है? ",

    // Forgot Password
    resetPassword: "पासवर्ड रीसेट करें",
    resetDesc:
        "अपना ईमेल दर्ज करें और हम आपको पासवर्ड रीसेट करने के लिए लिंक भेजेंगे",
    sendResetLink: "रीसेट लिंक भेजें",

    // Company Setup
    setUpProfile: "अपना प्रोफाइल सेट करें",
    companyDetailsDesc:
        "अपने इनवॉइस पर प्रोफेशनल दिखने के लिए कंपनी विवरण जोड़ें।",
    tapToUploadLogo: "लोगो अपलोड करने के लिए टैप करें",
    companyName: "कंपनी का नाम",
    businessEmail: "बिजनेस ईमेल",
    phoneNumber: "फोन नंबर",
    address: "पता",
    defaultCurrency: "डिफ़ॉल्ट मुद्रा",
    nextStep: "अगला कदम →",

    // Template Setup
    customizeYourLook: "अपनी लुक कस्टमाइज़ करें",
    chooseColorAndFont: "अपने इनवॉइस टेम्प्लेट के लिए रंग और फॉंट चुनें।",
    primaryColor: "प्राइमरी कलर",
    typography: "टाइपोग्राफी",
    finishSetup: "सेटअप पूरा करें →",

    // Dashboard
    dashboard: "डैशबोर्ड",
    heresYourOverview: "यहाँ आपका अवलोकन है",
    totalRevenue: "कुल आय",
    outstanding: "बकाया",
    overdue: "अतिदेय",
    recentActivity: "हाल की गतिविधि",
    seeAll: "सभी देखें",
    noInvoices: "कोई इनवॉइस नहीं",
    createFirstInvoice: "अपना पहला इनवॉइस बनाएं और शुरू करें",

    // Client Detail
    clientDetails: "क्लाइंट विवरण",
    open: "खुली",
    paid: "भुगतान की गई",
    projects: "प्रोजेक्ट",
    allCaughtUp: "सब कुछ अप टू डेट",
    call: "कॉल",
    email: "ईमेल",
    website: "वेबसाइट",
    create: "बनाएं",
    clientNotes: "क्लाइंट नोट्स",
    noNotesYet: "अभी कोई नोट नहीं। जोड़ने के लिए दाएं आइकन पर टैप करें।",
    cancel: "रद्द करें",
    saveNotes: "नोट्स सेव करें",
    pleaseWait: "कृपया प्रतीक्षा करें...",

    // Clients List
    noClientsFound: "कोई क्लाइंट नहीं मिला",
    tapToAddClient: "अपना पहला क्लाइंट जोड़ने के लिए + पर टैप करें",
    newClient: "नया क्लाइंट",
    addClientDetails: "इनवॉइसिंग शुरू करने के लिए क्लाइंट विवरण जोड़ें",
    contactName: "संपर्क नाम",
    companyWebsite: "कंपनी वेबसाइट",
    selectIndustry: "उद्योग चुनें",
    addClient: "क्लाइंट जोड़ें",

    // New Invoice
    newInvoice: "नया इनवॉइस",
    professionalInvoices: "सेकंड में प्रोफेशनल इनवॉइस",
    preview: "पूर्वावलोकन",
    client: "क्लाइंट",
    selectAClient: "एक क्लाइंट चुनें",
    dates: "तारीखें",
    issued: "जारी की गई",
    due: "देय तारीख",
    useDefaultCurrency: "डिफ़ॉल्ट मुद्रा का उपयोग करें",
    lineItems: "लाइन आइटम",
    addItem: "आइटम जोड़ें",
    itemDescription: "आइटम विवरण",
    qty: "मात्रा",
    rate: "दर",
    amount: "राशि",
    taxPercent: "कर %",
    discountPercent: "छूट %",
    acceptPaymentWithInvoice: "इनवॉइस के साथ भुगतान स्वीकार करें",
    includePaymentInstructions: "भुगतान निर्देश शामिल करें",
    paymentMethod: "भुगतान विधि",
    bankAccountDetails: "बैंक खाता विवरण",
    paypalEmail: "पेपाल ईमेल",
    stripeLink: "स्ट्राइप खाता / भुगतान लिंक",
    upiId: "UPI आईडी",
    subtotal: "उप-योग",
    totalDue: "कुल देय",
    generateAndSend: "बनाएं और भेजें",
    updateInvoice: "इनवॉइस अपडेट करें",

    // Invoice Detail
    invoiceDetails: "इनवॉइस विवरण",
    remind: "रिमाइंड करें",
    recordPayment: "भुगतान रिकॉर्ड करें",
    resendInvoice: "इनवॉइस दोबारा भेजें",
    billedTo: "बिल किया गया",
    paymentMethodLabel: "भुगतान विधि",
    items: "आइटम",
    activity: "गतिविधि",

    // Invoice Preview
    invoicePreview: "इनवॉइस पूर्वावलोकन",

    // Settings
    settings: "सेटिंग्स",
    monthlyRevenueGoal: "मासिक आय लक्ष्य",
    upgradeToPro: "प्रो में अपग्रेड करें",
    privacyAndSecurity: "गोपनीयता और सुरक्षा",
    helpAndSupport: "सहायता और समर्थन",
    checkForUpdates: "अपडेट जांचें",
    logOut: "लॉग आउट",
    deleteAccount: "खाता हटाएं",

    // Reports
    financialOverview: "वित्तीय अवलोकन",
    revenueTrend: "आय प्रवृत्ति",
    topClients: "शीर्ष क्लाइंट",
    noRevenueData: "कोई आय डेटा नहीं",
    noClientData: "अभी कोई क्लाइंट डेटा नहीं",

    // Messages
    pleaseEnterValidEmail: "कृपया एक वैध ईमेल दर्ज करें",
    pleaseFillAllFields: "कृपया सभी फ़ील्ड भरें",
    accountCreatedSuccess: "खाता सफलतापूर्वक बनाया गया!",
    invalidEmail: "अवैध ईमेल पता",
    passwordTooShort: "पासवर्ड कम से कम 6 अक्षर का होना चाहिए",
    acceptTerms: "कृपया नियम और गोपनीयता नीति स्वीकार करें",
    allFieldsRequired: "सभी फ़ील्ड आवश्यक हैं",
    invoiceCreated: "इनवॉइस बनाया गया!",
    invoiceUpdated: "इनवॉइस अपडेट किया गया!",
    invoiceDeleted: "इनवॉइस हटाया गया",
    invoiceSent: "इनवॉइस सफलतापूर्वक भेजा गया!",
    paymentRecorded: "{amount} का भुगतान रिकॉर्ड किया गया!",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> FR = {
    // Bottom Nav
    home: "Accueil",
    clients: "Clients",
    invoices: "Factures",
    reports: "Rapports",

    // Onboarding
    onboardingTitle1: "Envoyez des factures en quelques secondes",
    onboardingDesc1:
        "Créez des factures professionnelles avec votre logo et votre marque — sans tableur.",
    onboardingTitle2: "Soyez payé plus rapidement",
    onboardingDesc2:
        "Suivez les paiements, envoyez des rappels intelligents et voyez d'un coup d'œil qui vous doit de l'argent.",
    onboardingTitle3: "Travaillez comme un pro",
    onboardingDesc3:
        "Paiements partiels, frais de retard, notes client et rapports magnifiques — tout au même endroit.",
    getStarted: "Commencer",
    next: "Suivant",
    skip: "Passer",

    // Login
    welcomeBack: "Bienvenue",
    logInToManage: "Connectez-vous pour gérer vos factures",
    emailAddress: "Adresse e-mail",
    password: "Mot de passe",
    forgotPassword: "Mot de passe oublié ?",
    logIn: "Se connecter",
    dontHaveAccount: "Pas de compte ? ",
    signUp: "S'inscrire",

    // Register
    createAccount: "Créer un compte",
    startSendingInvoices:
        "Commencez à envoyer des factures et soyez payé plus rapidement",
    fullName: "Nom complet",
    iAgreeTo: "J'accepte les ",
    termsOfService: "Conditions d'utilisation",
    and: "et la",
    privacyPolicy: "Politique de confidentialité",
    createAccountBtn: "Créer un compte",
    alreadyHaveAccount: "Déjà un compte ? ",

    // Forgot Password
    resetPassword: "Réinitialiser le mot de passe",
    resetDesc:
        "Entrez votre e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe",
    sendResetLink: "Envoyer le lien",

    // Company Setup
    setUpProfile: "Configurez votre profil",
    companyDetailsDesc:
        "Ajoutez les détails de votre entreprise pour paraître professionnel sur vos factures.",
    tapToUploadLogo: "Appuyez pour télécharger le logo",
    companyName: "Nom de l'entreprise",
    businessEmail: "E-mail professionnel",
    phoneNumber: "Numéro de téléphone",
    address: "Adresse",
    defaultCurrency: "Devise par défaut",
    nextStep: "Étape suivante →",

    // Template Setup
    customizeYourLook: "Personnalisez votre apparence",
    chooseColorAndFont:
        "Choisissez une couleur et une police pour vos modèles de facture.",
    primaryColor: "COULEUR PRINCIPALE",
    typography: "TYPOGRAPHIE",
    finishSetup: "Terminer la configuration →",

    // Dashboard
    dashboard: "Tableau de bord",
    heresYourOverview: "Voici votre aperçu",
    totalRevenue: "Revenu Total",
    outstanding: "En souffrance",
    overdue: "En retard",
    recentActivity: "Activité Récente",
    seeAll: "Voir Tout",
    noInvoices: "Aucune facture",
    createFirstInvoice: "Créez votre première facture pour commencer",

    // Client Detail
    clientDetails: "Détails du Client",
    open: "Ouvertes",
    paid: "Payées",
    projects: "Projets",
    allCaughtUp: "Tout est à jour",
    call: "Appeler",
    email: "E-mail",
    website: "Site Web",
    create: "Créer",
    clientNotes: "Notes Client",
    noNotesYet:
        "Aucune note pour le moment. Appuyez sur l'icône droite pour ajouter.",
    cancel: "Annuler",
    saveNotes: "Enregistrer les Notes",
    pleaseWait: "Veuillez patienter...",

    // Clients List
    noClientsFound: "Aucun client trouvé",
    tapToAddClient: "Appuyez sur + pour ajouter votre premier client",
    newClient: "Nouveau Client",
    addClientDetails: "Ajoutez les détails du client pour commencer à facturer",
    contactName: "Nom du Contact",
    companyWebsite: "Site Web de l'Entreprise",
    selectIndustry: "Sélectionner le Secteur",
    addClient: "Ajouter Client",

    // New Invoice
    newInvoice: "Nouvelle Facture",
    professionalInvoices: "Factures professionnelles en quelques secondes",
    preview: "Aperçu",
    client: "Client",
    selectAClient: "Sélectionner un client",
    dates: "Dates",
    issued: "Émise",
    due: "Échéance",
    useDefaultCurrency: "Utiliser la Devise Par Défaut",
    lineItems: "Lignes",
    addItem: "Ajouter un Article",
    itemDescription: "Description de l'Article",
    qty: "Qté",
    rate: "Tarif",
    amount: "Montant",
    taxPercent: "Taxe %",
    discountPercent: "Remise %",
    acceptPaymentWithInvoice: "Accepter le Paiement avec Facture",
    includePaymentInstructions: "Inclure les instructions de paiement",
    paymentMethod: "Méthode de Paiement",
    bankAccountDetails: "Détails du Compte Bancaire",
    paypalEmail: "E-mail PayPal",
    stripeLink: "Compte Stripe / Lien de Paiement",
    upiId: "ID UPI",
    subtotal: "Sous-total",
    totalDue: "Total Dû",
    generateAndSend: "Générer et Envoyer",
    updateInvoice: "Mettre à Jour la Facture",

    // Invoice Detail
    invoiceDetails: "Détails de la Facture",
    remind: "Rappeler",
    recordPayment: "Enregistrer le Paiement",
    resendInvoice: "Renvoyer la Facture",
    billedTo: "FACTURÉ À",
    paymentMethodLabel: "MÉTHODE DE PAIEMENT",
    items: "Articles",
    activity: "Activité",

    // Invoice Preview
    invoicePreview: "Aperçu de la Facture",

    // Settings
    settings: "Paramètres",
    monthlyRevenueGoal: "Objectif de Revenu Mensuel",
    upgradeToPro: "Passer à Pro",
    privacyAndSecurity: "Confidentialité et Sécurité",
    helpAndSupport: "Aide et Support",
    checkForUpdates: "Vérifier les Mises à Jour",
    logOut: "Se Déconnecter",
    deleteAccount: "Supprimer le Compte",

    // Reports
    financialOverview: "Aperçu Financier",
    revenueTrend: "Tendance des Revenus",
    topClients: "Meilleurs Clients",
    noRevenueData: "Aucune donnée de revenu",
    noClientData: "Aucune donnée client pour le moment",

    // Messages
    pleaseEnterValidEmail: "Veuillez entrer une adresse e-mail valide",
    pleaseFillAllFields: "Veuillez remplir tous les champs",
    accountCreatedSuccess: "Compte créé avec succès !",
    invalidEmail: "Adresse e-mail invalide",
    passwordTooShort: "Le mot de passe doit contenir au moins 6 caractères",
    acceptTerms:
        "Veuillez accepter les conditions et la politique de confidentialité",
    allFieldsRequired: "Tous les champs sont requis",
    invoiceCreated: "Facture créée !",
    invoiceUpdated: "Facture mise à jour !",
    invoiceDeleted: "Facture supprimée",
    invoiceSent: "Facture envoyée avec succès !",
    paymentRecorded: "Paiement de {amount} enregistré !",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> DE = {
    // Bottom Nav
    home: "Start",
    clients: "Kunden",
    invoices: "Rechnungen",
    reports: "Berichte",

    // Onboarding
    onboardingTitle1: "Rechnungen in Sekunden versenden",
    onboardingDesc1:
        "Erstellen Sie professionelle Rechnungen mit Ihrem Logo und Branding — keine Tabellen nötig.",
    onboardingTitle2: "Schneller bezahlt werden",
    onboardingDesc2:
        "Zahlungen verfolgen, smarte Erinnerungen senden und auf einen Blick sehen, wer Ihnen schuldet.",
    onboardingTitle3: "Wie ein Profi arbeiten",
    onboardingDesc3:
        "Teilzahlungen, Säumnisgebühren, Kundennnotizen und schöne Berichte — alles an einem Ort.",
    getStarted: "Loslegen",
    next: "Weiter",
    skip: "Überspringen",

    // Login
    welcomeBack: "Willkommen zurück",
    logInToManage: "Melden Sie sich an, um Ihre Rechnungen zu verwalten",
    emailAddress: "E-Mail-Adresse",
    password: "Passwort",
    forgotPassword: "Passwort vergessen?",
    logIn: "Anmelden",
    dontHaveAccount: "Kein Konto? ",
    signUp: "Registrieren",

    // Register
    createAccount: "Konto erstellen",
    startSendingInvoices:
        "Beginnen Sie Rechnungen zu senden und schneller bezahlt zu werden",
    fullName: "Vollständiger Name",
    iAgreeTo: "Ich stimme den ",
    termsOfService: "Nutzungsbedingungen",
    and: "und der",
    privacyPolicy: "Datenschutzerklärung zu",
    createAccountBtn: "Konto erstellen",
    alreadyHaveAccount: "Haben Sie bereits ein Konto? ",

    // Forgot Password
    resetPassword: "Passwort zurücksetzen",
    resetDesc:
        "Geben Sie Ihre E-Mail ein und wir senden Ihnen einen Link zum Zurücksetzen",
    sendResetLink: "Link senden",

    // Company Setup
    setUpProfile: "Ihr Profil einrichten",
    companyDetailsDesc:
        "Fügen Sie Ihre Unternehmensdetails hinzu, um auf Ihren Rechnungen professionell auszusehen.",
    tapToUploadLogo: "Tippen zum Hochladen des Logos",
    companyName: "Firmenname",
    businessEmail: "Geschäftliche E-Mail",
    phoneNumber: "Telefonnummer",
    address: "Adresse",
    defaultCurrency: "Standardwährung",
    nextStep: "Nächster Schritt →",

    // Template Setup
    customizeYourLook: "Passen Sie Ihr Aussehen an",
    chooseColorAndFont:
        "Wählen Sie eine Farbe und Schrift für Ihre Rechnungsvorlagen.",
    primaryColor: "PRIMÄRFARBE",
    typography: "TYPOGRAPHIE",
    finishSetup: "Einrichtung abschließen →",

    // Dashboard
    dashboard: "Dashboard",
    heresYourOverview: "Hier ist Ihre Übersicht",
    totalRevenue: "Gesamteinnahmen",
    outstanding: "Offen",
    overdue: "Überfällig",
    recentActivity: "Letzte Aktivität",
    seeAll: "Alle ansehen",
    noInvoices: "Keine Rechnungen",
    createFirstInvoice: "Erstellen Sie Ihre erste Rechnung, um zu beginnen",

    // Client Detail
    clientDetails: "Kundendetails",
    open: "Offen",
    paid: "Bezahlt",
    projects: "Projekte",
    allCaughtUp: "Alles aktuell",
    call: "Anrufen",
    email: "E-Mail",
    website: "Website",
    create: "Erstellen",
    clientNotes: "Kundennotizen",
    noNotesYet:
        "Noch keine Notizen. Tippen Sie auf das rechte Symbol, um welche hinzuzufügen.",
    cancel: "Abbrechen",
    saveNotes: "Notizen speichern",
    pleaseWait: "Bitte warten...",

    // Clients List
    noClientsFound: "Keine Kunden gefunden",
    tapToAddClient: "Tippen Sie auf + um Ihren ersten Kunden hinzuzufügen",
    newClient: "Neuer Kunde",
    addClientDetails:
        "Fügen Sie Kundendetails hinzu, um mit der Rechnungsstellung zu beginnen",
    contactName: "Kontaktname",
    companyWebsite: "Firmenwebsite",
    selectIndustry: "Branche auswählen",
    addClient: "Kunde hinzufügen",

    // New Invoice
    newInvoice: "Neue Rechnung",
    professionalInvoices: "Professionelle Rechnungen in Sekunden",
    preview: "Vorschau",
    client: "Kunde",
    selectAClient: "Wählen Sie einen Kunden aus",
    dates: "Daten",
    issued: "Ausgestellt",
    due: "Fällig",
    useDefaultCurrency: "Standardwährung verwenden",
    lineItems: "Positionen",
    addItem: "Position hinzufügen",
    itemDescription: "Positionsbeschreibung",
    qty: "Menge",
    rate: "Einzelpreis",
    amount: "Betrag",
    taxPercent: "Steuer %",
    discountPercent: "Rabatt %",
    acceptPaymentWithInvoice: "Zahlung mit Rechnung akzeptieren",
    includePaymentInstructions: "Zahlungsanweisungen einbeziehen",
    paymentMethod: "Zahlungsmethode",
    bankAccountDetails: "Bankkontodetails",
    paypalEmail: "PayPal-E-Mail",
    stripeLink: "Stripe-Konto / Zahlungslink",
    upiId: "UPI-ID",
    subtotal: "Zwischensumme",
    totalDue: "Gesamtbetrag fällig",
    generateAndSend: "Erstellen und Senden",
    updateInvoice: "Rechnung aktualisieren",

    // Invoice Detail
    invoiceDetails: "Rechnungsdetails",
    remind: "Erinnern",
    recordPayment: "Zahlung verbuchen",
    resendInvoice: "Rechnung erneut senden",
    billedTo: "RECHNUNG AN",
    paymentMethodLabel: "ZAHLUNGSART",
    items: "Positionen",
    activity: "Aktivität",

    // Invoice Preview
    invoicePreview: "Rechnungsvorschau",

    // Settings
    settings: "Einstellungen",
    monthlyRevenueGoal: "Monatliches Umsatzziel",
    upgradeToPro: "Auf Pro upgraden",
    privacyAndSecurity: "Datenschutz und Sicherheit",
    helpAndSupport: "Hilfe und Support",
    checkForUpdates: "Nach Updates suchen",
    logOut: "Abmelden",
    deleteAccount: "Konto löschen",

    // Reports
    financialOverview: "Finanzübersicht",
    revenueTrend: "Umsatztrend",
    topClients: "Top-Kunden",
    noRevenueData: "Keine Umsatzdaten",
    noClientData: "Noch keine Kundendaten",

    // Messages
    pleaseEnterValidEmail: "Bitte geben Sie eine gültige E-Mail-Adresse ein",
    pleaseFillAllFields: "Bitte füllen Sie alle Felder aus",
    accountCreatedSuccess: "Konto erfolgreich erstellt!",
    invalidEmail: "Ungültige E-Mail-Adresse",
    passwordTooShort: "Das Passwort muss mindestens 6 Zeichen lang sein",
    acceptTerms:
        "Bitte akzeptieren Sie die Nutzungsbedingungen und Datenschutzerklärung",
    allFieldsRequired: "Alle Felder sind erforderlich",
    invoiceCreated: "Rechnung erstellt!",
    invoiceUpdated: "Rechnung aktualisiert!",
    invoiceDeleted: "Rechnung gelöscht",
    invoiceSent: "Rechnung erfolgreich gesendet!",
    paymentRecorded: "Zahlung von {amount} verbucht!",

    appName: "InvoicePay",
  };

  static const Map<String, dynamic> ID = {
    // Bottom Nav
    home: "Beranda",
    clients: "Klien",
    invoices: "Faktur",
    reports: "Laporan",

    // Onboarding
    onboardingTitle1: "Kirim Faktur dalam Hitungan Detik",
    onboardingDesc1:
        "Buat faktur profesional dengan logo dan branding Anda — tanpa spreadsheet.",
    onboardingTitle2: "Dapatkan Pembayaran Lebih Cepat",
    onboardingDesc2:
        "Lacak pembayaran, kirim pengingat pintar, dan lihat sekilas siapa yang berhutang kepada Anda.",
    onboardingTitle3: "Bekerja Seperti Profesional",
    onboardingDesc3:
        "Pembayaran parsial, denda keterlambatan, catatan klien, dan laporan indah — semuanya di satu tempat.",
    getStarted: "Mulai",
    next: "Lanjut",
    skip: "Lewati",

    // Login
    welcomeBack: "Selamat Datang Kembali",
    logInToManage: "Masuk untuk mengelola faktur Anda",
    emailAddress: "Alamat Email",
    password: "Kata Sandi",
    forgotPassword: "Lupa Kata Sandi?",
    logIn: "Masuk",
    dontHaveAccount: "Belum punya akun? ",
    signUp: "Daftar",

    // Register
    createAccount: "Buat Akun",
    startSendingInvoices:
        "Mulai kirim faktur dan dapatkan pembayaran lebih cepat",
    fullName: "Nama Lengkap",
    iAgreeTo: "Saya setuju dengan ",
    termsOfService: "Syarat Layanan",
    and: "dan",
    privacyPolicy: "Kebijakan Privasi",
    createAccountBtn: "Buat Akun",
    alreadyHaveAccount: "Sudah punya akun? ",

    // Forgot Password
    resetPassword: "Atur Ulang Kata Sandi",
    resetDesc:
        "Masukkan email Anda dan kami akan kirim link untuk mengatur ulang kata sandi",
    sendResetLink: "Kirim Link Reset",

    // Company Setup
    setUpProfile: "Atur profil Anda",
    companyDetailsDesc:
        "Tambahkan detail perusahaan Anda untuk terlihat profesional di faktur.",
    tapToUploadLogo: "Ketuk untuk unggah logo",
    companyName: "Nama Perusahaan",
    businessEmail: "Email Bisnis",
    phoneNumber: "Nomor Telepon",
    address: "Alamat",
    defaultCurrency: "Mata Uang Default",
    nextStep: "Langkah Selanjutnya →",

    // Template Setup
    customizeYourLook: "Kustomisasi tampilan Anda",
    chooseColorAndFont: "Pilih warna dan fonta untuk template faktur Anda.",
    primaryColor: "WARNA UTAMA",
    typography: "TIPOGRAFI",
    finishSetup: "Selesaikan Pengaturan →",

    // Dashboard
    dashboard: "Dasbor",
    heresYourOverview: "Ini ringkasan Anda",
    totalRevenue: "Pendapatan Total",
    outstanding: "Belum Dibayar",
    overdue: "Terlambat",
    recentActivity: "Aktivitas Terbaru",
    seeAll: "Lihat Semua",
    noInvoices: "Tidak ada faktur",
    createFirstInvoice: "Buat faktur pertama Anda untuk memulai",

    // Client Detail
    clientDetails: "Detail Klien",
    open: "Terbuka",
    paid: "Dibayar",
    projects: "Proyek",
    allCaughtUp: "Semua sudah terbayar",
    call: "Telepon",
    email: "Email",
    website: "Website",
    create: "Buat",
    clientNotes: "Catatan Klien",
    noNotesYet: "Belum ada catatan. Ketuk ikon kanan untuk menambahkan.",
    cancel: "Batal",
    saveNotes: "Simpan Catatan",
    pleaseWait: "Mohon tunggu...",

    // Clients List
    noClientsFound: "Tidak ada klien ditemukan",
    tapToAddClient: "Ketuk + untuk menambahkan klien pertama Anda",
    newClient: "Klien Baru",
    addClientDetails: "Tambahkan detail klien untuk mulai membuat faktur",
    contactName: "Nama Kontak",
    companyWebsite: "Website Perusahaan",
    selectIndustry: "Pilih Industri",
    addClient: "Tambah Klien",

    // New Invoice
    newInvoice: "Faktur Baru",
    professionalInvoices: "Faktur profesional dalam hitungan detik",
    preview: "Pratinjau",
    client: "Klien",
    selectAClient: "Pilih klien",
    dates: "Tanggal",
    issued: "Diterbitkan",
    due: "Jatuh Tempo",
    useDefaultCurrency: "Gunakan Mata Uang Default",
    lineItems: "Item Baris",
    addItem: "Tambah Item",
    itemDescription: "Deskripsi Item",
    qty: "Jml",
    rate: "Harga",
    amount: "Jumlah",
    taxPercent: "Pajak %",
    discountPercent: "Diskon %",
    acceptPaymentWithInvoice: "Terima Pembayaran dengan Faktur",
    includePaymentInstructions: "Sertakan instruksi pembayaran",
    paymentMethod: "Metode Pembayaran",
    bankAccountDetails: "Detail Rekening Bank",
    paypalEmail: "Email PayPal",
    stripeLink: "Akun Stripe / Link Pembayaran",
    upiId: "ID UPI",
    subtotal: "Subtotal",
    totalDue: "Total Jatuh Tempo",
    generateAndSend: "Buat & Kirim",
    updateInvoice: "Perbarui Faktur",

    // Invoice Detail
    invoiceDetails: "Detail Faktur",
    remind: "Ingatkan",
    recordPayment: "Catat Pembayaran",
    resendInvoice: "Kirim Ulang Faktur",
    billedTo: "DITAGIHKAN KEPADA",
    paymentMethodLabel: "METODE PEMBAYARAN",
    items: "Item",
    activity: "Aktivitas",

    // Invoice Preview
    invoicePreview: "Pratinjau Faktur",

    // Settings
    settings: "Pengaturan",
    monthlyRevenueGoal: "Target Pendapatan Bulanan",
    upgradeToPro: "Upgrade ke Pro",
    privacyAndSecurity: "Privasi & Keamanan",
    helpAndSupport: "Bantuan & Dukungan",
    checkForUpdates: "Periksa Pembaruan",
    logOut: "Keluar",
    deleteAccount: "Hapus Akun",

    // Reports
    financialOverview: "Ikhtisar Keuangan",
    revenueTrend: "Tren Pendapatan",
    topClients: "Klien Teratas",
    noRevenueData: "Tidak ada data pendapatan",
    noClientData: "Belum ada data klien",

    // Messages
    pleaseEnterValidEmail: "Silakan masukkan email yang valid",
    pleaseFillAllFields: "Silakan isi semua kolom",
    accountCreatedSuccess: "Akun berhasil dibuat!",
    invalidEmail: "Alamat email tidak valid",
    passwordTooShort: "Kata sandi harus minimal 6 karakter",
    acceptTerms: "Silakan terima syarat dan kebijakan privasi",
    allFieldsRequired: "Semua kolom wajib diisi",
    invoiceCreated: "Faktur dibuat!",
    invoiceUpdated: "Faktur diperbarui!",
    invoiceDeleted: "Faktur dihapus",
    invoiceSent: "Faktur berhasil dikirim!",
    paymentRecorded: "Pembayaran {amount} dicatat!",

    appName: "InvoicePay",
  };
}
