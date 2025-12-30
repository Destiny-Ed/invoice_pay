import 'package:flutter_localization/flutter_localization.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

mixin AppLocale {
  // Bottom Navigation Bar
  static const String home = 'home';
  static const String clients = 'clients';
  static const String invoices = 'invoices';
  static const String reports = 'reports';

  static const String settingsTitle = 'settingsTitle';
  static const String language = 'language';
  static const String selectLanguage = 'selectLanguage';
  static const String systemDefault = 'systemDefault';

  static const String goodMorning = 'goodMorning';
  static const String goodAfternoon = 'goodAfternoon';
  static const String goodEvening = 'goodEvening';
  static const String goodNight = 'goodNight';

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

  // Client Screens
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

  // Messages
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

  static const String sendInvoice = 'sendInvoice';
  static const String whatsapp = 'whatsapp';
  static const String otherApps = 'otherApps';
  static const String failedToGeneratePdf = 'failedToGeneratePdf';
  static const String failedToSharePdf = 'failedToSharePdf';
  static const String failedToDownloadPdf = 'failedToDownloadPdf';
  static const String logOutQuestion = 'logOutQuestion';
  static const String logOutMessage = 'logOutMessage';
  static const String stayLoggedIn = 'stayLoggedIn';
  static const String deleteAccountPermanently = 'deleteAccountPermanently';
  static const String deleteAccountMessage = 'deleteAccountMessage';
  static const String enterPasswordToConfirm = 'enterPasswordToConfirm';
  static const String accountDeletedSuccess = 'accountDeletedSuccess';
  static const String deleteForever = 'deleteForever';
  static const String selectThisColor = 'selectThisColor';
  static const String setMonthlyGoal = 'setMonthlyGoal';
  static const String motivateYourself = 'motivateYourself';
  static const String goalUpdatedTo = 'goalUpdatedTo';
  static const String saveGoal = 'saveGoal';
  static const String allTime = 'allTime';
  static const String completeInvoicesToSeeTrends =
      'completeInvoicesToSeeTrends';
  static const String searchInvoices = 'searchInvoices';
  static const String all = 'all';
  static const String from = 'from';
  static const String to = 'to';
  static const String deleteInvoiceQuestion = 'deleteInvoiceQuestion';
  static const String deleteInvoiceConfirm = 'deleteInvoiceConfirm';
  static const String delete = 'delete';
  static const String thisCannotBeUndone = 'thisCannotBeUndone';
  static const String editInvoice = 'editInvoice';
  static const String deleteInvoice = 'deleteInvoice';
  static const String failedToFetchInvoice = 'failedToFetchInvoice';
  static const String amountPaid = 'amountPaid';
  static const String balanceDue = 'balanceDue';
  static const String paymentAmount = 'paymentAmount';
  static const String enterValidAmount = 'enterValidAmount';
  static const String cannotExceedBalance = 'cannotExceedBalance';
  static const String paymentOf = 'paymentOf';
  static const String recorded = 'recorded';
  static const String billTo = 'billTo';
  static const String status = 'status';
  static const String description = 'description';
  static const String bankTransfer = 'bankTransfer';
  static const String payPal = 'payPal';
  static const String stripe = 'stripe';
  static const String upi = 'upi';
  static const String paymentDetails = 'paymentDetails';
  static const String target = 'target';
  static const String noProjectsYet = 'noProjectsYet';
  static const String projectsComingSoon = 'projectsComingSoon';
  static const String addNotesHint = 'addNotesHint';
  static const String createInvoice = 'createInvoice';

  static const String month = 'month';
  static const String achieved = 'achieved';
  static const String pleaseFindInvoiceAttached = 'pleaseFindInvoiceAttached';
  static const String hiGreeting = 'hiGreeting';
  static const String invoiceDetailsLabel = 'invoiceDetailsLabel';
  static const String invoiceLabel = 'invoiceLabel';
  static const String dueDateLabel = 'dueDateLabel';
  static const String amountDueLabel = 'amountDueLabel';
  static const String bestRegards = 'bestRegards';
  static const String thankYouBusiness = 'thankYouBusiness';
  static const String invoicePayFinancialReport = 'invoicePayFinancialReport';
  static const String generatedByInvoicePay = 'generatedByInvoicePay';
  static const String periodLabel = 'periodLabel';
  static const String invoicePayReportSubject = 'invoicePayReportSubject';
  static const String proudlyPoweredBy = 'proudlyPoweredBy';
  static const String thankYouFooter = 'thankYouFooter';
  static const String descriptionLabel = 'descriptionLabel';
  static const String industryTechnology = 'industryTechnology';
  static const String industryHealthcare = 'industryHealthcare';
  static const String industryFinance = 'industryFinance';
  static const String industryEducation = 'industryEducation';
  static const String industryRetail = 'industryRetail';
  static const String industryRealEstate = 'industryRealEstate';
  static const String industryMarketing = 'industryMarketing';
  static const String industryDesign = 'industryDesign';
  static const String industryConsulting = 'industryConsulting';
  static const String industryManufacturing = 'industryManufacturing';
  static const String industryHospitality = 'industryHospitality';
  static const String industryOther = 'industryOther';
  static const String bankHintExample = 'bankHintExample';
  static const String yourBusiness = 'yourBusiness';
  static const String invoiceViewed = 'invoiceViewed';
  static const String paymentReceived = 'paymentReceived';
  static const String invoiceOverdue = 'invoiceOverdue';

  // General
  static const String appName = 'appName';

  static const Map<String, dynamic> EN = {
    goodMorning: "Good Morning!",
    goodAfternoon: "Good Afternoon!",
    goodEvening: "Good Evening!",
    goodNight: "Good Night!",
    home: "Home",
    clients: "Clients",
    invoices: "Invoices",
    reports: "Reports",
    yourBusiness: "Your Business",

    invoiceViewed: "Invoice Viewed",
    paymentReceived: "Payment Received",
    invoiceOverdue: "Invoice Overdue",

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

    settingsTitle: "Settings",
    language: "Language",
    selectLanguage: "Select Language",
    systemDefault: "System Default",

    welcomeBack: "Welcome Back",
    logInToManage: "Log in to manage your invoices",
    emailAddress: "Email Address",
    password: "Password",
    forgotPassword: "Forgot Password?",
    logIn: "Log In",
    dontHaveAccount: "Don't have an account? ",
    signUp: "Sign Up",

    createAccount: "Create Account",
    startSendingInvoices: "Start sending invoices and getting paid faster",
    fullName: "Full Name",
    iAgreeTo: "I agree to the ",
    termsOfService: "Terms of Service",
    and: "and",
    privacyPolicy: "Privacy Policy",
    createAccountBtn: "Create Account",
    alreadyHaveAccount: "Already have an account? ",

    resetPassword: "Reset Password",
    resetDesc:
        "Enter your email and we'll send you a link to reset your password",
    sendResetLink: "Send Reset Link",

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

    customizeYourLook: "Customize your look",
    chooseColorAndFont: "Choose a color and font for your invoice templates.",
    primaryColor: "PRIMARY COLOR",
    typography: "TYPOGRAPHY",
    finishSetup: "Finish Setup →",

    dashboard: "Dashboard",
    heresYourOverview: "Here's your overview",
    totalRevenue: "Total Revenue",
    outstanding: "Outstanding",
    overdue: "Overdue",
    recentActivity: "Recent Activity",
    seeAll: "See All",
    noInvoices: "No invoices",
    createFirstInvoice: "Create your first invoice to get started",

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

    noClientsFound: "No clients found",
    tapToAddClient: "Tap + to add your first client",
    newClient: "New Client",
    addClientDetails: "Add client details to start invoicing",
    contactName: "Contact Name",
    companyWebsite: "Company Website",
    selectIndustry: "Select Industry",
    addClient: "Add Client",

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

    invoiceDetails: "Invoice Details",
    remind: "Remind",
    recordPayment: "Record Payment",
    resendInvoice: "Resend Invoice",
    billedTo: "BILLED TO",
    paymentMethodLabel: "PAYMENT METHOD",
    items: "Items",
    activity: "Activity",

    invoicePreview: "Invoice Preview",

    settings: "Settings",
    monthlyRevenueGoal: "Monthly Revenue Goal",
    upgradeToPro: "Upgrade to Pro",
    privacyAndSecurity: "Privacy & Security",
    helpAndSupport: "Help & Support",
    checkForUpdates: "Check for Updates",
    logOut: "Log Out",
    deleteAccount: "Delete Account",

    financialOverview: "Financial Overview",
    revenueTrend: "Revenue Trend",
    topClients: "Top Clients",
    noRevenueData: "No revenue data",
    noClientData: "No client data yet",

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

    sendInvoice: "Send Invoice",
    whatsapp: "WhatsApp",
    otherApps: "Other Apps",
    failedToGeneratePdf: "Failed to generate PDF",
    failedToSharePdf: "Failed to share PDF",
    failedToDownloadPdf: "Failed to download PDF",
    logOutQuestion: "Log Out?",
    logOutMessage:
        "You will be signed out of your account.\nAll your data is safely saved.",
    stayLoggedIn: "Stay Logged In",
    deleteAccountPermanently: "Delete Account Permanently?",
    deleteAccountMessage:
        "This action is irreversible. All your data will be permanently deleted.\n\nPlease enter your password to confirm.",
    enterPasswordToConfirm: "Please enter your password to confirm.",
    accountDeletedSuccess: "Account deleted successfully",
    deleteForever: "Delete Forever",
    selectThisColor: "Select This Color",
    setMonthlyGoal: "Set Monthly Goal",
    motivateYourself: "Motivate yourself with a clear target",
    goalUpdatedTo: "Goal updated to",
    saveGoal: "Save Goal",
    allTime: "All Time",
    completeInvoicesToSeeTrends: "Complete some invoices to see trends",
    searchInvoices: "Search invoices...",
    all: "All",
    from: "From",
    to: "To",
    deleteInvoiceQuestion: "Delete Invoice?",
    deleteInvoiceConfirm: "Are you sure you want to delete invoice",
    delete: "Delete",
    thisCannotBeUndone: "This cannot be undone.",
    editInvoice: "Edit Invoice",
    deleteInvoice: "Delete Invoice",
    failedToFetchInvoice:
        "Oh, we apologize\nFailed to fetch invoice details at the time. Please try again",
    amountPaid: "Amount Paid",
    balanceDue: "Balance Due",
    paymentAmount: "Payment Amount",
    enterValidAmount: "Enter valid amount",
    cannotExceedBalance: "Cannot exceed balance",
    paymentOf: "Payment of",
    recorded: "recorded!",
    billTo: "Bill To",
    status: "Status",
    description: "Description",
    bankTransfer: "Bank Transfer",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Payment Details",
    target: "Target",
    noProjectsYet: "No projects yet",
    projectsComingSoon: "Projects coming soon",
    addNotesHint:
        "Add notes about this client...\ne.g. Payment terms, preferences, contact person, etc.",
    createInvoice: "Create Invoice",

    month: "month",
    achieved: "achieved",
    pleaseFindInvoiceAttached:
        "Please find your invoice attached for your review.",
    hiGreeting: "Hi",
    invoiceDetailsLabel: "Invoice Details:",
    invoiceLabel: "Invoice",
    dueDateLabel: "Due Date",
    amountDueLabel: "Amount Due",
    bestRegards: "Best regards,",
    thankYouBusiness:
        "Thank you for your business! We appreciate your prompt payment.",
    invoicePayFinancialReport: "InvoicePay Financial Report",
    generatedByInvoicePay: "Generated with ❤️ by InvoicePay",
    periodLabel: "Period",
    invoicePayReportSubject: "InvoicePay Report",
    proudlyPoweredBy: "Proudly Powered by InvoicePay",
    thankYouFooter: "Thank you for your business!",
    descriptionLabel: "Description",
    industryTechnology: "Technology",
    industryHealthcare: "Healthcare",
    industryFinance: "Finance",
    industryEducation: "Education",
    industryRetail: "Retail",
    industryRealEstate: "Real Estate",
    industryMarketing: "Marketing",
    industryDesign: "Design",
    industryConsulting: "Consulting",
    industryManufacturing: "Manufacturing",
    industryHospitality: "Hospitality",
    industryOther: "Other",
    bankHintExample: "Account Name, Number, Bank, IFSC",
  };

  static const Map<String, dynamic> ES = {
    home: "Inicio",
    clients: "Clientes",
    invoices: "Facturas",
    reports: "Informes",
    yourBusiness: "Tu Negocio",

    goodMorning: "¡Buenos días!",
    goodAfternoon: "¡Buenas tardes!",
    goodEvening: "¡Buenas tardes!",
    goodNight: "¡Buenas noches!",

    invoiceViewed: "Factura Vista",
    paymentReceived: "Pago Recibido",
    invoiceOverdue: "Factura Vencida",

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

    settingsTitle: "Configuración",
    language: "Idioma",
    selectLanguage: "Seleccionar Idioma",
    systemDefault: "Predeterminado del Sistema",

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

    sendInvoice: "Enviar Factura",
    whatsapp: "WhatsApp",
    otherApps: "Otras Aplicaciones",
    failedToGeneratePdf: "Error al generar PDF",
    failedToSharePdf: "Error al compartir PDF",
    failedToDownloadPdf: "Error al descargar PDF",
    logOutQuestion: "¿Cerrar Sesión?",
    logOutMessage:
        "Se cerrará la sesión de tu cuenta.\nTodos tus datos están guardados de forma segura.",
    stayLoggedIn: "Mantener Sesión",
    deleteAccountPermanently: "¿Eliminar Cuenta Permanentemente?",
    deleteAccountMessage:
        "Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.\n\nPor favor ingresa tu contraseña para confirmar.",
    enterPasswordToConfirm: "Por favor ingresa tu contraseña para confirmar.",
    accountDeletedSuccess: "Cuenta eliminada exitosamente",
    deleteForever: "Eliminar para Siempre",
    selectThisColor: "Seleccionar Este Color",
    setMonthlyGoal: "Establecer Meta Mensual",
    motivateYourself: "Motívate con un objetivo claro",
    goalUpdatedTo: "Meta actualizada a",
    saveGoal: "Guardar Meta",
    allTime: "Todo el Tiempo",
    completeInvoicesToSeeTrends:
        "Completa algunas facturas para ver tendencias",
    searchInvoices: "Buscar facturas...",
    all: "Todo",
    from: "Desde",
    to: "Hasta",
    deleteInvoiceQuestion: "¿Eliminar Factura?",
    deleteInvoiceConfirm: "¿Estás seguro de eliminar la factura",
    delete: "Eliminar",
    thisCannotBeUndone: "Esto no se puede deshacer.",
    editInvoice: "Editar Factura",
    deleteInvoice: "Eliminar Factura",
    failedToFetchInvoice:
        "Lo sentimos\nNo se pudieron cargar los detalles de la factura en este momento. Intenta de nuevo",
    amountPaid: "Monto Pagado",
    balanceDue: "Saldo Pendiente",
    paymentAmount: "Monto del Pago",
    enterValidAmount: "Ingresa un monto válido",
    cannotExceedBalance: "No puede exceder el saldo",
    paymentOf: "Pago de",
    recorded: "registrado!",
    billTo: "Facturar A",
    status: "Estado",
    description: "Descripción",
    bankTransfer: "Transferencia Bancaria",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Detalles de Pago",
    target: "Objetivo",
    noProjectsYet: "Aún no hay proyectos",
    projectsComingSoon: "Proyectos próximamente",
    addNotesHint:
        "Agrega notas sobre este cliente...\ne.g. Términos de pago, preferencias, persona de contacto, etc.",
    createInvoice: "Crear Factura",

    month: "mes",
    achieved: "logrado",
    pleaseFindInvoiceAttached: "Adjunto encontrarás tu factura para revisión.",
    hiGreeting: "Hola",
    invoiceDetailsLabel: "Detalles de la Factura:",
    invoiceLabel: "Factura",
    dueDateLabel: "Fecha de Vencimiento",
    amountDueLabel: "Monto Pendiente",
    bestRegards: "Saludos cordiales,",
    thankYouBusiness: "¡Gracias por tu negocio! Apreciamos tu pago puntual.",
    invoicePayFinancialReport: "Reporte Financiero de InvoicePay",
    generatedByInvoicePay: "Generado con ❤️ por InvoicePay",
    periodLabel: "Período",
    invoicePayReportSubject: "Reporte InvoicePay",
    proudlyPoweredBy: "Orgullosamente impulsado por InvoicePay",
    thankYouFooter: "¡Gracias por tu negocio!",
    descriptionLabel: "Descripción",
    industryTechnology: "Tecnología",
    industryHealthcare: "Salud",
    industryFinance: "Finanzas",
    industryEducation: "Educación",
    industryRetail: "Retail",
    industryRealEstate: "Bienes Raíces",
    industryMarketing: "Marketing",
    industryDesign: "Diseño",
    industryConsulting: "Consultoría",
    industryManufacturing: "Manufactura",
    industryHospitality: "Hospitalidad",
    industryOther: "Otro",
    bankHintExample: "Nombre de Cuenta, Número, Banco, IFSC",
  };

  static const Map<String, dynamic> PT = {
    home: "Início",
    clients: "Clientes",
    invoices: "Faturas",
    reports: "Relatórios",
    yourBusiness: "Seu Negócio",

    goodMorning: "Bom dia!",
    goodAfternoon: "Boa tarde!",
    goodEvening: "Boa tarde!",
    goodNight: "Boa noite!",

    invoiceViewed: "Fatura Visualizada",
    paymentReceived: "Pagamento Recebido",
    invoiceOverdue: "Fatura Vencida",

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

    welcomeBack: "Bem-vindo de Volta",
    logInToManage: "Faça login para gerenciar suas faturas",
    emailAddress: "Endereço de Email",
    password: "Senha",
    forgotPassword: "Esqueceu a Senha?",
    logIn: "Entrar",
    dontHaveAccount: "Não tem conta? ",
    signUp: "Cadastrar",

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

    resetPassword: "Redefinir Senha",
    resetDesc: "Digite seu email e enviaremos um link para redefinir sua senha",
    sendResetLink: "Enviar Link de Redefinição",

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

    customizeYourLook: "Personalize sua aparência",
    chooseColorAndFont: "Escolha uma cor e fonte para seus modelos de fatura.",
    primaryColor: "COR PRIMÁRIA",
    typography: "TIPOGRAFIA",
    finishSetup: "Finalizar Configuração →",

    dashboard: "Painel",
    heresYourOverview: "Aqui está seu resumo",
    totalRevenue: "Receita Total",
    outstanding: "Pendentes",
    overdue: "Vencidas",
    recentActivity: "Atividade Recente",
    seeAll: "Ver Tudo",
    noInvoices: "Sem faturas",
    createFirstInvoice: "Crie sua primeira fatura para começar",

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

    noClientsFound: "Nenhum cliente encontrado",
    tapToAddClient: "Toque + para adicionar seu primeiro cliente",
    newClient: "Novo Cliente",
    addClientDetails: "Adicione detalhes do cliente para começar a faturar",
    contactName: "Nome de Contato",
    companyWebsite: "Site da Empresa",
    selectIndustry: "Selecionar Setor",
    addClient: "Adicionar Cliente",

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

    invoiceDetails: "Detalhes da Fatura",
    remind: "Lembrar",
    recordPayment: "Registrar Pagamento",
    resendInvoice: "Reenviar Fatura",
    billedTo: "FATURADO PARA",
    paymentMethodLabel: "MÉTODO DE PAGAMENTO",
    items: "Itens",
    activity: "Atividade",

    invoicePreview: "Visualização da Fatura",

    settings: "Configurações",
    monthlyRevenueGoal: "Meta de Receita Mensal",
    upgradeToPro: "Atualizar para Pro",
    privacyAndSecurity: "Privacidade e Segurança",
    helpAndSupport: "Ajuda e Suporte",
    checkForUpdates: "Verificar Atualizações",
    logOut: "Sair",
    deleteAccount: "Excluir Conta",

    financialOverview: "Resumo Financeiro",
    revenueTrend: "Tendência de Receita",
    topClients: "Principais Clientes",
    noRevenueData: "Sem dados de receita",
    noClientData: "Sem dados de clientes ainda",

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

    sendInvoice: "Enviar Fatura",
    whatsapp: "WhatsApp",
    otherApps: "Outros Apps",
    failedToGeneratePdf: "Falha ao gerar PDF",
    failedToSharePdf: "Falha ao compartilhar PDF",
    failedToDownloadPdf: "Falha ao baixar PDF",
    logOutQuestion: "Sair?",
    logOutMessage:
        "Você será desconectado da sua conta.\nTodos os seus dados estão salvos com segurança.",
    stayLoggedIn: "Permanecer Conectado",
    deleteAccountPermanently: "Excluir Conta Permanentemente?",
    deleteAccountMessage:
        "Esta ação é irreversível. Todos os seus dados serão excluídos permanentemente.\n\nPor favor, insira sua senha para confirmar.",
    enterPasswordToConfirm: "Por favor, insira sua senha para confirmar.",
    accountDeletedSuccess: "Conta excluída com sucesso",
    deleteForever: "Excluir para Sempre",
    selectThisColor: "Selecionar Esta Cor",
    setMonthlyGoal: "Definir Meta Mensal",
    motivateYourself: "Motiva-se com uma meta clara",
    goalUpdatedTo: "Meta atualizada para",
    saveGoal: "Salvar Meta",
    allTime: "Todo o Tempo",
    completeInvoicesToSeeTrends: "Complete algumas faturas para ver tendências",
    searchInvoices: "Buscar faturas...",
    all: "Todos",
    from: "De",
    to: "Até",
    deleteInvoiceQuestion: "Excluir Fatura?",
    deleteInvoiceConfirm: "Tem certeza que deseja excluir a fatura",
    delete: "Excluir",
    thisCannotBeUndone: "Isso não pode ser desfeito.",
    editInvoice: "Editar Fatura",
    deleteInvoice: "Excluir Fatura",
    failedToFetchInvoice:
        "Desculpe-nos\nFalha ao carregar detalhes da fatura no momento. Tente novamente",
    amountPaid: "Valor Pago",
    balanceDue: "Saldo Devedor",
    paymentAmount: "Valor do Pagamento",
    enterValidAmount: "Insira um valor válido",
    cannotExceedBalance: "Não pode exceder o saldo",
    paymentOf: "Pagamento de",
    recorded: "registrado!",
    billTo: "Faturado Para",
    status: "Status",
    description: "Descrição",
    bankTransfer: "Transferência Bancária",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Detalhes de Pagamento",
    target: "Meta",
    noProjectsYet: "Nenhum projeto ainda",
    projectsComingSoon: "Projetos em breve",
    addNotesHint:
        "Adicione notas sobre este cliente...\ne.g. Termos de pagamento, preferências, contato responsável, etc.",
    createInvoice: "Criar Fatura",

    month: "mês",
    achieved: "alcançado",
    pleaseFindInvoiceAttached:
        "Por favor, encontre sua fatura em anexo para revisão.",
    hiGreeting: "Olá",
    invoiceDetailsLabel: "Detalhes da Fatura:",
    invoiceLabel: "Fatura",
    dueDateLabel: "Data de Vencimento",
    amountDueLabel: "Valor Devido",
    bestRegards: "Atenciosamente,",
    thankYouBusiness:
        "Obrigado pelo seu negócio! Agradecemos seu pagamento rápido.",
    invoicePayFinancialReport: "Relatório Financeiro InvoicePay",
    generatedByInvoicePay: "Gerado com ❤️ por InvoicePay",
    periodLabel: "Período",
    invoicePayReportSubject: "Relatório InvoicePay",
    proudlyPoweredBy: "Orgulhosamente powered by InvoicePay",
    thankYouFooter: "Obrigado pelo seu negócio!",
    descriptionLabel: "Descrição",
    industryTechnology: "Tecnologia",
    industryHealthcare: "Saúde",
    industryFinance: "Finanças",
    industryEducation: "Educação",
    industryRetail: "Varejo",
    industryRealEstate: "Imobiliário",
    industryMarketing: "Marketing",
    industryDesign: "Design",
    industryConsulting: "Consultoria",
    industryManufacturing: "Manufatura",
    industryHospitality: "Hospitalidade",
    industryOther: "Outro",
    bankHintExample: "Nome da Conta, Número, Banco, IFSC",

    settingsTitle: "Configurações",
    language: "Idioma",
    selectLanguage: "Selecionar Idioma",
    systemDefault: "Padrão do Sistema",
  };

  static const Map<String, dynamic> HI = {
    home: "होम",
    clients: "क्लाइंट",
    invoices: "इनवॉइस",
    reports: "रिपोर्ट",

    goodMorning: "सुप्रभात!",
    goodAfternoon: "नमस्ते!",
    goodEvening: "शुभ संध्या!",
    goodNight: "शुभ रात्रि!",

    invoiceViewed: "इनवॉइस देखा गया",
    paymentReceived: "भुगतान प्राप्त हुआ",
    invoiceOverdue: "इनवॉइस अतिदेय",

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
    yourBusiness: "आपका व्यवसाय",

    settingsTitle: "सेटिंग्स",
    language: "भाषा",
    selectLanguage: "भाषा चुनें",
    systemDefault: "सिस्टम डिफ़ॉल्ट",

    welcomeBack: "वापस स्वागत है",
    logInToManage: "अपने इनवॉइस प्रबंधित करने के लिए लॉग इन करें",
    emailAddress: "ईमेल पता",
    password: "पासवर्ड",
    forgotPassword: "पासवर्ड भूल गए?",
    logIn: "लॉग इन",
    dontHaveAccount: "खाता नहीं है? ",
    signUp: "साइन अप",

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

    resetPassword: "पासवर्ड रीसेट करें",
    resetDesc:
        "अपना ईमेल दर्ज करें और हम आपको पासवर्ड रीसेट करने के लिए लिंक भेजेंगे",
    sendResetLink: "रीसेट लिंक भेजें",

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

    customizeYourLook: "अपनी लुक कस्टमाइज़ करें",
    chooseColorAndFont: "अपने इनवॉइस टेम्प्लेट के लिए रंग और फॉंट चुनें।",
    primaryColor: "प्राइमरी कलर",
    typography: "टाइपोग्राफी",
    finishSetup: "सेटअप पूरा करें →",

    dashboard: "डैशबोर्ड",
    heresYourOverview: "यहाँ आपका अवलोकन है",
    totalRevenue: "कुल आय",
    outstanding: "बकाया",
    overdue: "अतिदेय",
    recentActivity: "हाल की गतिविधि",
    seeAll: "सभी देखें",
    noInvoices: "कोई इनवॉइस नहीं",
    createFirstInvoice: "अपना पहला इनवॉइस बनाएं और शुरू करें",

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

    noClientsFound: "कोई क्लाइंट नहीं मिला",
    tapToAddClient: "अपना पहला क्लाइंट जोड़ने के लिए + पर टैप करें",
    newClient: "नया क्लाइंट",
    addClientDetails: "इनवॉइसिंग शुरू करने के लिए क्लाइंट विवरण जोड़ें",
    contactName: "संपर्क नाम",
    companyWebsite: "कंपनी वेबसाइट",
    selectIndustry: "उद्योग चुनें",
    addClient: "क्लाइंट जोड़ें",

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

    invoiceDetails: "इनवॉइस विवरण",
    remind: "रिमाइंड करें",
    recordPayment: "भुगतान रिकॉर्ड करें",
    resendInvoice: "इनवॉइस दोबारा भेजें",
    billedTo: "बिल किया गया",
    paymentMethodLabel: "भुगतान विधि",
    items: "आइटम",
    activity: "गतिविधि",

    invoicePreview: "इनवॉइस पूर्वावलोकन",

    settings: "सेटिंग्स",
    monthlyRevenueGoal: "मासिक आय लक्ष्य",
    upgradeToPro: "प्रो में अपग्रेड करें",
    privacyAndSecurity: "गोपनीयता और सुरक्षा",
    helpAndSupport: "सहायता और समर्थन",
    checkForUpdates: "अपडेट जांचें",
    logOut: "लॉग आउट",
    deleteAccount: "खाता हटाएं",

    financialOverview: "वित्तीय अवलोकन",
    revenueTrend: "आय प्रवृत्ति",
    topClients: "शीर्ष क्लाइंट",
    noRevenueData: "कोई आय डेटा नहीं",
    noClientData: "अभी कोई क्लाइंट डेटा नहीं",

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

    sendInvoice: "इनवॉइस भेजें",
    whatsapp: "व्हाट्सएप",
    otherApps: "अन्य ऐप्स",
    failedToGeneratePdf: "PDF जनरेट करने में विफल",
    failedToSharePdf: "PDF शेयर करने में विफल",
    failedToDownloadPdf: "PDF डाउनलोड करने में विफल",
    logOutQuestion: "लॉग आउट करें?",
    logOutMessage:
        "आप अपने खाते से लॉग आउट हो जाएंगे।\nआपका सारा डेटा सुरक्षित है।",
    stayLoggedIn: "लॉग इन रहें",
    deleteAccountPermanently: "खाता हमेशा के लिए हटाएं?",
    deleteAccountMessage:
        "यह कार्रवाई अपरिवर्तनीय है। आपका सारा डेटा हमेशा के लिए हटा दिया जाएगा।\n\nकृपया पुष्टि के लिए अपना पासवर्ड डालें।",
    enterPasswordToConfirm: "कृपया पुष्टि के लिए अपना पासवर्ड डालें।",
    accountDeletedSuccess: "खाता सफलतापूर्वक हटा दिया गया",
    deleteForever: "हमेशा के लिए हटाएं",
    selectThisColor: "यह रंग चुनें",
    setMonthlyGoal: "मासिक लक्ष्य सेट करें",
    motivateYourself: "स्पष्ट लक्ष्य के साथ खुद को प्रेरित करें",
    goalUpdatedTo: "लक्ष्य अपडेट किया गया",
    saveGoal: "लक्ष्य सेव करें",
    allTime: "सभी समय",
    completeInvoicesToSeeTrends: "ट्रेंड देखने के लिए कुछ इनवॉइस पूरे करें",
    searchInvoices: "इनवॉइस खोजें...",
    all: "सभी",
    from: "से",
    to: "तक",
    deleteInvoiceQuestion: "इनवॉइस हटाएं?",
    deleteInvoiceConfirm: "क्या आप वाकई इनवॉइस हटाना चाहते हैं",
    delete: "हटाएं",
    thisCannotBeUndone: "यह वापस नहीं किया जा सकता।",
    editInvoice: "इनवॉइस संपादित करें",
    deleteInvoice: "इनवॉइस हटाएं",
    failedToFetchInvoice:
        "क्षमा करें\nइस समय इनवॉइस विवरण लोड करने में असफल। कृपया पुनः प्रयास करें",
    amountPaid: "भुगतान की गई राशि",
    balanceDue: "शेष राशि",
    paymentAmount: "भुगतान राशि",
    enterValidAmount: "वैध राशि दर्ज करें",
    cannotExceedBalance: "शेष राशि से अधिक नहीं हो सकता",
    paymentOf: "का भुगतान",
    recorded: "रिकॉर्ड किया गया!",
    billTo: "बिल किया गया",
    status: "स्थिति",
    description: "विवरण",
    bankTransfer: "बैंक ट्रांसफर",
    payPal: "पेपाल",
    stripe: "स्ट्राइप",
    upi: "UPI",
    paymentDetails: "भुगतान विवरण",
    target: "लक्ष्य",
    noProjectsYet: "अभी कोई प्रोजेक्ट नहीं",
    projectsComingSoon: "प्रोजेक्ट जल्द आ रहे हैं",
    addNotesHint:
        "इस क्लाइंट के बारे में नोट्स जोड़ें...\ne.g. भुगतान शर्तें, प्राथमिकताएं, संपर्क व्यक्ति, आदि।",
    createInvoice: "इनवॉइस बनाएं",

    month: "mês",
    achieved: "alcançado",
    pleaseFindInvoiceAttached:
        "Por favor, encontre sua fatura em anexo para revisão.",
    hiGreeting: "Olá",
    invoiceDetailsLabel: "Detalhes da Fatura:",
    invoiceLabel: "Fatura",
    dueDateLabel: "Data de Vencimento",
    amountDueLabel: "Valor Devido",
    bestRegards: "Atenciosamente,",
    thankYouBusiness:
        "Obrigado pelo seu negócio! Agradecemos seu pagamento rápido.",
    invoicePayFinancialReport: "Relatório Financeiro InvoicePay",
    generatedByInvoicePay: "Gerado com ❤️ por InvoicePay",
    periodLabel: "Período",
    invoicePayReportSubject: "Relatório InvoicePay",
    proudlyPoweredBy: "Orgulhosamente powered by InvoicePay",
    thankYouFooter: "Obrigado pelo seu negócio!",
    descriptionLabel: "Descrição",
    industryTechnology: "Tecnologia",
    industryHealthcare: "Saúde",
    industryFinance: "Finanças",
    industryEducation: "Educação",
    industryRetail: "Varejo",
    industryRealEstate: "Imobiliário",
    industryMarketing: "Marketing",
    industryDesign: "Design",
    industryConsulting: "Consultoria",
    industryManufacturing: "Manufatura",
    industryHospitality: "Hospitalidade",
    industryOther: "Outro",
    bankHintExample: "Nome da Conta, Número, Banco, IFSC",
  };

  static const Map<String, dynamic> FR = {
    home: "Accueil",
    clients: "Clients",
    invoices: "Factures",
    reports: "Rapports",

    goodMorning: "Bonjour !",
    goodAfternoon: "Bon après-midi !",
    goodEvening: "Bonsoir !",
    goodNight: "Bonne nuit !",

    invoiceViewed: "Facture Consultée",
    paymentReceived: "Paiement Reçu",
    invoiceOverdue: "Facture En Retard",

    settingsTitle: "Paramètres",
    language: "Langue",
    selectLanguage: "Sélectionner la Langue",
    systemDefault: "Par Défaut du Système",

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
    yourBusiness: "Votre Entreprise",

    welcomeBack: "Bienvenue",
    logInToManage: "Connectez-vous pour gérer vos factures",
    emailAddress: "Adresse e-mail",
    password: "Mot de passe",
    forgotPassword: "Mot de passe oublié ?",
    logIn: "Se connecter",
    dontHaveAccount: "Pas de compte ? ",
    signUp: "S'inscrire",

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

    resetPassword: "Réinitialiser le mot de passe",
    resetDesc:
        "Entrez votre e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe",
    sendResetLink: "Envoyer le lien",

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

    customizeYourLook: "Personnalisez votre apparence",
    chooseColorAndFont:
        "Choisissez une couleur et une police pour vos modèles de facture.",
    primaryColor: "COULEUR PRINCIPALE",
    typography: "TYPOGRAPHIE",
    finishSetup: "Terminer la configuration →",

    dashboard: "Tableau de bord",
    heresYourOverview: "Voici votre aperçu",
    totalRevenue: "Revenu Total",
    outstanding: "En souffrance",
    overdue: "En retard",
    recentActivity: "Activité Récente",
    seeAll: "Voir Tout",
    noInvoices: "Aucune facture",
    createFirstInvoice: "Créez votre première facture pour commencer",

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

    noClientsFound: "Aucun client trouvé",
    tapToAddClient: "Appuyez sur + pour ajouter votre premier client",
    newClient: "Nouveau Client",
    addClientDetails: "Ajoutez les détails du client pour commencer à facturer",
    contactName: "Nom du Contact",
    companyWebsite: "Site Web de l'Entreprise",
    selectIndustry: "Sélectionner le Secteur",
    addClient: "Ajouter Client",

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

    invoiceDetails: "Détails de la Facture",
    remind: "Rappeler",
    recordPayment: "Enregistrer le Paiement",
    resendInvoice: "Renvoyer la Facture",
    billedTo: "FACTURÉ À",
    paymentMethodLabel: "MÉTHODE DE PAIEMENT",
    items: "Articles",
    activity: "Activité",

    invoicePreview: "Aperçu de la Facture",

    settings: "Paramètres",
    monthlyRevenueGoal: "Objectif de Revenu Mensuel",
    upgradeToPro: "Passer à Pro",
    privacyAndSecurity: "Confidentialité et Sécurité",
    helpAndSupport: "Aide et Support",
    checkForUpdates: "Vérifier les Mises à Jour",
    logOut: "Se Déconnecter",
    deleteAccount: "Supprimer le Compte",

    financialOverview: "Aperçu Financier",
    revenueTrend: "Tendance des Revenus",
    topClients: "Meilleurs Clients",
    noRevenueData: "Aucune donnée de revenu",
    noClientData: "Aucune donnée client pour le moment",

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

    sendInvoice: "Envoyer la Facture",
    whatsapp: "WhatsApp",
    otherApps: "Autres Applications",
    failedToGeneratePdf: "Échec de génération du PDF",
    failedToSharePdf: "Échec du partage du PDF",
    failedToDownloadPdf: "Échec du téléchargement du PDF",
    logOutQuestion: "Se Déconnecter ?",
    logOutMessage:
        "Vous serez déconnecté de votre compte.\nToutes vos données sont enregistrées en toute sécurité.",
    stayLoggedIn: "Rester Connecté",
    deleteAccountPermanently: "Supprimer le Compte Définitivement ?",
    deleteAccountMessage:
        "Cette action est irréversible. Toutes vos données seront définitivement supprimées.\n\nVeuillez saisir votre mot de passe pour confirmer.",
    enterPasswordToConfirm:
        "Veuillez saisir votre mot de passe pour confirmer.",
    accountDeletedSuccess: "Compte supprimé avec succès",
    deleteForever: "Supprimer Définitivement",
    selectThisColor: "Sélectionner Cette Couleur",
    setMonthlyGoal: "Définir l'Objectif Mensuel",
    motivateYourself: "Motivez-vous avec un objectif clair",
    goalUpdatedTo: "Objectif mis à jour à",
    saveGoal: "Enregistrer l'Objectif",
    allTime: "Tout le Temps",
    completeInvoicesToSeeTrends:
        "Complétez quelques factures pour voir les tendances",
    searchInvoices: "Rechercher des factures...",
    all: "Tout",
    from: "De",
    to: "À",
    deleteInvoiceQuestion: "Supprimer la Facture ?",
    deleteInvoiceConfirm: "Êtes-vous sûr de vouloir supprimer la facture",
    delete: "Supprimer",
    thisCannotBeUndone: "Cela ne peut pas être annulé.",
    editInvoice: "Modifier la Facture",
    deleteInvoice: "Supprimer la Facture",
    failedToFetchInvoice:
        "Désolé\nÉchec du chargement des détails de la facture pour le moment. Veuillez réessayer",
    amountPaid: "Montant Payé",
    balanceDue: "Solde Dû",
    paymentAmount: "Montant du Paiement",
    enterValidAmount: "Saisir un montant valide",
    cannotExceedBalance: "Ne peut pas dépasser le solde",
    paymentOf: "Paiement de",
    recorded: "enregistré !",
    billTo: "Facturé À",
    status: "Statut",
    description: "Description",
    bankTransfer: "Virement Bancaire",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Détails du Paiement",
    target: "Objectif",
    noProjectsYet: "Aucun projet pour le moment",
    projectsComingSoon: "Projets à venir",
    addNotesHint:
        "Ajoutez des notes sur ce client...\ne.g. Conditions de paiement, préférences, personne de contact, etc.",
    createInvoice: "Créer une Facture",

    month: "mois",
    achieved: "atteint",
    pleaseFindInvoiceAttached:
        "Veuillez trouver votre facture en pièce jointe pour examen.",
    hiGreeting: "Bonjour",
    invoiceDetailsLabel: "Détails de la Facture :",
    invoiceLabel: "Facture",
    dueDateLabel: "Date d'Échéance",
    amountDueLabel: "Montant Dû",
    bestRegards: "Cordialement,",
    thankYouBusiness:
        "Merci pour votre confiance ! Nous apprécions votre paiement rapide.",
    invoicePayFinancialReport: "Rapport Financier InvoicePay",
    generatedByInvoicePay: "Généré avec ❤️ par InvoicePay",
    periodLabel: "Période",
    invoicePayReportSubject: "Rapport InvoicePay",
    proudlyPoweredBy: "Fièrement propulsé par InvoicePay",
    thankYouFooter: "Merci pour votre confiance !",
    descriptionLabel: "Description",
    industryTechnology: "Technologie",
    industryHealthcare: "Santé",
    industryFinance: "Finance",
    industryEducation: "Éducation",
    industryRetail: "Commerce de détail",
    industryRealEstate: "Immobilier",
    industryMarketing: "Marketing",
    industryDesign: "Design",
    industryConsulting: "Conseil",
    industryManufacturing: "Fabrication",
    industryHospitality: "Hôtellerie",
    industryOther: "Autre",
    bankHintExample: "Nom du Compte, Numéro, Banque, IFSC",
  };

  static const Map<String, dynamic> DE = {
    home: "Start",
    clients: "Kunden",
    invoices: "Rechnungen",
    reports: "Berichte",
    yourBusiness: "Ihr Unternehmen",

    goodMorning: "Guten Morgen!",
    goodAfternoon: "Guten Tag!",
    goodEvening: "Guten Abend!",
    goodNight: "Gute Nacht!",

    invoiceViewed: "Rechnung Angesehen",
    paymentReceived: "Zahlung Eingegangen",
    invoiceOverdue: "Rechnung Überfällig",

    settingsTitle: "Einstellungen",
    language: "Sprache",
    selectLanguage: "Sprache Auswählen",
    systemDefault: "Systemstandard",

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

    welcomeBack: "Willkommen zurück",
    logInToManage: "Melden Sie sich an, um Ihre Rechnungen zu verwalten",
    emailAddress: "E-Mail-Adresse",
    password: "Passwort",
    forgotPassword: "Passwort vergessen?",
    logIn: "Anmelden",
    dontHaveAccount: "Kein Konto? ",
    signUp: "Registrieren",

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

    resetPassword: "Passwort zurücksetzen",
    resetDesc:
        "Geben Sie Ihre E-Mail ein und wir senden Ihnen einen Link zum Zurücksetzen",
    sendResetLink: "Link senden",

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

    customizeYourLook: "Passen Sie Ihr Aussehen an",
    chooseColorAndFont:
        "Wählen Sie eine Farbe und Schrift für Ihre Rechnungsvorlagen.",
    primaryColor: "PRIMÄRFARBE",
    typography: "TYPOGRAPHIE",
    finishSetup: "Einrichtung abschließen →",

    dashboard: "Dashboard",
    heresYourOverview: "Hier ist Ihre Übersicht",
    totalRevenue: "Gesamteinnahmen",
    outstanding: "Offen",
    overdue: "Überfällig",
    recentActivity: "Letzte Aktivität",
    seeAll: "Alle ansehen",
    noInvoices: "Keine Rechnungen",
    createFirstInvoice: "Erstellen Sie Ihre erste Rechnung, um zu beginnen",

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

    noClientsFound: "Keine Kunden gefunden",
    tapToAddClient: "Tippen Sie auf + um Ihren ersten Kunden hinzuzufügen",
    newClient: "Neuer Kunde",
    addClientDetails:
        "Fügen Sie Kundendetails hinzu, um mit der Rechnungsstellung zu beginnen",
    contactName: "Kontaktname",
    companyWebsite: "Firmenwebsite",
    selectIndustry: "Branche auswählen",
    addClient: "Kunde hinzufügen",

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

    invoiceDetails: "Rechnungsdetails",
    remind: "Erinnern",
    recordPayment: "Zahlung verbuchen",
    resendInvoice: "Rechnung erneut senden",
    billedTo: "RECHNUNG AN",
    paymentMethodLabel: "ZAHLUNGSART",
    items: "Positionen",
    activity: "Aktivität",

    invoicePreview: "Rechnungsvorschau",

    settings: "Einstellungen",
    monthlyRevenueGoal: "Monatliches Umsatzziel",
    upgradeToPro: "Auf Pro upgraden",
    privacyAndSecurity: "Datenschutz und Sicherheit",
    helpAndSupport: "Hilfe und Support",
    checkForUpdates: "Nach Updates suchen",
    logOut: "Abmelden",
    deleteAccount: "Konto löschen",

    financialOverview: "Finanzübersicht",
    revenueTrend: "Umsatztrend",
    topClients: "Top-Kunden",
    noRevenueData: "Keine Umsatzdaten",
    noClientData: "Noch keine Kundendaten",

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

    sendInvoice: "Rechnung Senden",
    whatsapp: "WhatsApp",
    otherApps: "Andere Apps",
    failedToGeneratePdf: "PDF konnte nicht generiert werden",
    failedToSharePdf: "PDF konnte nicht geteilt werden",
    failedToDownloadPdf: "PDF konnte nicht heruntergeladen werden",
    logOutQuestion: "Abmelden?",
    logOutMessage:
        "Sie werden von Ihrem Konto abgemeldet.\nAlle Ihre Daten sind sicher gespeichert.",
    stayLoggedIn: "Angemeldet Bleiben",
    deleteAccountPermanently: "Konto Dauerhaft Löschen?",
    deleteAccountMessage:
        "Diese Aktion ist unwiderruflich. Alle Ihre Daten werden dauerhaft gelöscht.\n\nBitte geben Sie Ihr Passwort zur Bestätigung ein.",
    enterPasswordToConfirm: "Bitte geben Sie Ihr Passwort zur Bestätigung ein.",
    accountDeletedSuccess: "Konto erfolgreich gelöscht",
    deleteForever: "Dauerhaft Löschen",
    selectThisColor: "Diese Farbe Auswählen",
    setMonthlyGoal: "Monatliches Ziel Festlegen",
    motivateYourself: "Motivieren Sie sich mit einem klaren Ziel",
    goalUpdatedTo: "Ziel aktualisiert auf",
    saveGoal: "Ziel Speichern",
    allTime: "Gesamte Zeit",
    completeInvoicesToSeeTrends:
        "Schließen Sie einige Rechnungen ab, um Trends zu sehen",
    searchInvoices: "Rechnungen durchsuchen...",
    all: "Alle",
    from: "Von",
    to: "Bis",
    deleteInvoiceQuestion: "Rechnung Löschen?",
    deleteInvoiceConfirm:
        "Sind Sie sicher, dass Sie die Rechnung löschen möchten",
    delete: "Löschen",
    thisCannotBeUndone: "Dies kann nicht rückgängig gemacht werden.",
    editInvoice: "Rechnung Bearbeiten",
    deleteInvoice: "Rechnung Löschen",
    failedToFetchInvoice:
        "Entschuldigung\nFehler beim Laden der Rechnungsdetails im Moment. Bitte versuchen Sie es erneut",
    amountPaid: "Bezahlter Betrag",
    balanceDue: "Offener Betrag",
    paymentAmount: "Zahlungsbetrag",
    enterValidAmount: "Geben Sie einen gültigen Betrag ein",
    cannotExceedBalance: "Darf den offenen Betrag nicht überschreiten",
    paymentOf: "Zahlung von",
    recorded: "verbucht!",
    billTo: "Rechnung An",
    status: "Status",
    description: "Beschreibung",
    bankTransfer: "Banküberweisung",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Zahlungsdetails",
    target: "Ziel",
    noProjectsYet: "Noch keine Projekte",
    projectsComingSoon: "Projekte kommen bald",
    addNotesHint:
        "Notizen zu diesem Kunden hinzufügen...\nz.B. Zahlungsbedingungen, Vorlieben, Ansprechpartner usw.",
    createInvoice: "Rechnung Erstellen",

    month: "mois",
    achieved: "atteint",
    pleaseFindInvoiceAttached:
        "Veuillez trouver votre facture en pièce jointe pour examen.",
    hiGreeting: "Bonjour",
    invoiceDetailsLabel: "Détails de la Facture :",
    invoiceLabel: "Facture",
    dueDateLabel: "Date d'Échéance",
    amountDueLabel: "Montant Dû",
    bestRegards: "Cordialement,",
    thankYouBusiness:
        "Merci pour votre confiance ! Nous apprécions votre paiement rapide.",
    invoicePayFinancialReport: "Rapport Financier InvoicePay",
    generatedByInvoicePay: "Généré avec ❤️ par InvoicePay",
    periodLabel: "Période",
    invoicePayReportSubject: "Rapport InvoicePay",
    proudlyPoweredBy: "Fièrement propulsé par InvoicePay",
    thankYouFooter: "Merci pour votre confiance !",
    descriptionLabel: "Description",
    industryTechnology: "Technologie",
    industryHealthcare: "Santé",
    industryFinance: "Finance",
    industryEducation: "Éducation",
    industryRetail: "Commerce de détail",
    industryRealEstate: "Immobilier",
    industryMarketing: "Marketing",
    industryDesign: "Design",
    industryConsulting: "Conseil",
    industryManufacturing: "Fabrication",
    industryHospitality: "Hôtellerie",
    industryOther: "Autre",
    bankHintExample: "Nom du Compte, Numéro, Banque, IFSC",
  };

  static const Map<String, dynamic> ID = {
    home: "Beranda",
    clients: "Klien",
    invoices: "Faktur",
    reports: "Laporan",

    goodMorning: "Selamat Pagi!",
    goodAfternoon: "Selamat Siang!",
    goodEvening: "Selamat Sore!",
    goodNight: "Selamat Malam!",

    settingsTitle: "Pengaturan",
    language: "Bahasa",
    selectLanguage: "Pilih Bahasa",
    systemDefault: "Default Sistem",

    invoiceViewed: "Faktur Dilihat",
    paymentReceived: "Pembayaran Diterima",
    invoiceOverdue: "Faktur Terlambat",

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
    yourBusiness: "Bisnis Anda",

    welcomeBack: "Selamat Datang Kembali",
    logInToManage: "Masuk untuk mengelola faktur Anda",
    emailAddress: "Alamat Email",
    password: "Kata Sandi",
    forgotPassword: "Lupa Kata Sandi?",
    logIn: "Masuk",
    dontHaveAccount: "Belum punya akun? ",
    signUp: "Daftar",

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

    resetPassword: "Atur Ulang Kata Sandi",
    resetDesc:
        "Masukkan email Anda dan kami akan kirim link untuk mengatur ulang kata sandi",
    sendResetLink: "Kirim Link Reset",

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

    customizeYourLook: "Kustomisasi tampilan Anda",
    chooseColorAndFont: "Pilih warna dan fonta untuk template faktur Anda.",
    primaryColor: "WARNA UTAMA",
    typography: "TIPOGRAFI",
    finishSetup: "Selesaikan Pengaturan →",

    dashboard: "Dasbor",
    heresYourOverview: "Ini ringkasan Anda",
    totalRevenue: "Pendapatan Total",
    outstanding: "Belum Dibayar",
    overdue: "Terlambat",
    recentActivity: "Aktivitas Terbaru",
    seeAll: "Lihat Semua",
    noInvoices: "Tidak ada faktur",
    createFirstInvoice: "Buat faktur pertama Anda untuk memulai",

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

    noClientsFound: "Tidak ada klien ditemukan",
    tapToAddClient: "Ketuk + untuk menambahkan klien pertama Anda",
    newClient: "Klien Baru",
    addClientDetails: "Tambahkan detail klien untuk mulai membuat faktur",
    contactName: "Nama Kontak",
    companyWebsite: "Website Perusahaan",
    selectIndustry: "Pilih Industri",
    addClient: "Tambah Klien",

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

    invoiceDetails: "Detail Faktur",
    remind: "Ingatkan",
    recordPayment: "Catat Pembayaran",
    resendInvoice: "Kirim Ulang Faktur",
    billedTo: "DITAGIHKAN KEPADA",
    paymentMethodLabel: "METODE PEMBAYARAN",
    items: "Item",
    activity: "Aktivitas",

    invoicePreview: "Pratinjau Faktur",

    settings: "Pengaturan",
    monthlyRevenueGoal: "Target Pendapatan Bulanan",
    upgradeToPro: "Upgrade ke Pro",
    privacyAndSecurity: "Privasi & Keamanan",
    helpAndSupport: "Bantuan & Dukungan",
    checkForUpdates: "Periksa Pembaruan",
    logOut: "Keluar",
    deleteAccount: "Hapus Akun",

    financialOverview: "Ikhtisar Keuangan",
    revenueTrend: "Tren Pendapatan",
    topClients: "Klien Teratas",
    noRevenueData: "Tidak ada data pendapatan",
    noClientData: "Belum ada data klien",

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

    sendInvoice: "Kirim Faktur",
    whatsapp: "WhatsApp",
    otherApps: "Aplikasi Lain",
    failedToGeneratePdf: "Gagal menghasilkan PDF",
    failedToSharePdf: "Gagal membagikan PDF",
    failedToDownloadPdf: "Gagal mengunduh PDF",
    logOutQuestion: "Keluar?",
    logOutMessage:
        "Anda akan keluar dari akun Anda.\nSemua data Anda tersimpan dengan aman.",
    stayLoggedIn: "Tetap Masuk",
    deleteAccountPermanently: "Hapus Akun Secara Permanen?",
    deleteAccountMessage:
        "Tindakan ini tidak dapat dibatalkan. Semua data Anda akan dihapus secara permanen.\n\nSilakan masukkan kata sandi untuk mengonfirmasi.",
    enterPasswordToConfirm: "Silakan masukkan kata sandi untuk mengonfirmasi.",
    accountDeletedSuccess: "Akun berhasil dihapus",
    deleteForever: "Hapus Selamanya",
    selectThisColor: "Pilih Warna Ini",
    setMonthlyGoal: "Tetapkan Target Bulanan",
    motivateYourself: "Motivasi diri dengan target yang jelas",
    goalUpdatedTo: "Target diperbarui menjadi",
    saveGoal: "Simpan Target",
    allTime: "Sepanjang Waktu",
    completeInvoicesToSeeTrends:
        "Selesaikan beberapa faktur untuk melihat tren",
    searchInvoices: "Cari faktur...",
    all: "Semua",
    from: "Dari",
    to: "Sampai",
    deleteInvoiceQuestion: "Hapus Faktur?",
    deleteInvoiceConfirm: "Apakah Anda yakin ingin menghapus faktur",
    delete: "Hapus",
    thisCannotBeUndone: "Ini tidak dapat dibatalkan.",
    editInvoice: "Edit Faktur",
    deleteInvoice: "Hapus Faktur",
    failedToFetchInvoice:
        "Maaf\nGagal memuat detail faktur saat ini. Silakan coba lagi",
    amountPaid: "Jumlah yang Dibayar",
    balanceDue: "Saldo Terutang",
    paymentAmount: "Jumlah Pembayaran",
    enterValidAmount: "Masukkan jumlah yang valid",
    cannotExceedBalance: "Tidak boleh melebihi saldo",
    paymentOf: "Pembayaran sebesar",
    recorded: "dicatat!",
    billTo: "Ditagihkan Kepada",
    status: "Status",
    description: "Deskripsi",
    bankTransfer: "Transfer Bank",
    payPal: "PayPal",
    stripe: "Stripe",
    upi: "UPI",
    paymentDetails: "Detail Pembayaran",
    target: "Target",
    noProjectsYet: "Belum ada proyek",
    projectsComingSoon: "Proyek segera hadir",
    addNotesHint:
        "Tambahkan catatan tentang klien ini...\ncontoh: Ketentuan pembayaran, preferensi, kontak utama, dll.",
    createInvoice: "Buat Faktur",

    month: "bulan",
    achieved: "tercapai",
    pleaseFindInvoiceAttached:
        "Mohon temukan faktur Anda terlampir untuk ditinjau.",
    hiGreeting: "Halo",
    invoiceDetailsLabel: "Detail Faktur:",
    invoiceLabel: "Faktur",
    dueDateLabel: "Tanggal Jatuh Tempo",
    amountDueLabel: "Jumlah Terutang",
    bestRegards: "Hormat kami,",
    thankYouBusiness:
        "Terima kasih atas bisnis Anda! Kami menghargai pembayaran cepat Anda.",
    invoicePayFinancialReport: "Laporan Keuangan InvoicePay",
    generatedByInvoicePay: "Dibuat dengan ❤️ oleh InvoicePay",
    periodLabel: "Periode",
    invoicePayReportSubject: "Laporan InvoicePay",
    proudlyPoweredBy: "Dengan bangga didukung oleh InvoicePay",
    thankYouFooter: "Terima kasih atas bisnis Anda!",
    descriptionLabel: "Deskripsi",
    industryTechnology: "Teknologi",
    industryHealthcare: "Kesehatan",
    industryFinance: "Keuangan",
    industryEducation: "Pendidikan",
    industryRetail: "Ritel",
    industryRealEstate: "Properti",
    industryMarketing: "Pemasaran",
    industryDesign: "Desain",
    industryConsulting: "Konsultasi",
    industryManufacturing: "Manufaktur",
    industryHospitality: "Perhotelan",
    industryOther: "Lainnya",
    bankHintExample: "Nama Rekening, Nomor, Bank, IFSC",
  };
}
