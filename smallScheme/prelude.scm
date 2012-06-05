(define (<= x y) (not (< y x)))
(define (> x y) (< y x))
(define (>= x y) (not (< x y)))

(define (list? x)
  (if (null? x)
      #t
      (if (pair? x)
          (list? (cdr x))
          #f)))
(define (list . x) x)
(define (length x)
  (define (iter n t)
    (if (null? t)
        n
        (iter (+ n 1) (cdr t))))
  (iter 0 x))
(define (memq o l)
  (if (null? l)
      #f
      (if (eq? o (car l))
          l
          (memq o (cdr l)))))
(define (last x)
  (if (null? (cdr x))
      (car x)
      (last (cdr x))))
(define (append l1 l2)
  (define (iter l)
    (if (null? l)
        l2
        (cons (car l) (iter (cdr l)))))
  (iter l1))

(define (not x) (if x #f #t))

(define (neq? x y) (not (eq? x y)))
(define (equal? x y)
  (if (pair? x)
      (if (pair? y)
          (if (equal? (car x) (car y))
              (equal? (cdr x) (cdr y))
              #f)
          #f)
      (eq? x y)))

;; ついで
(define (reverse l)
  (define (iter l1 l2)
    (if (null? l1)
        l2
        (iter (cdr l1) (cons (car l1) l2))))
  (iter l ()))


;; followings are macros
(define-macro (let fst . lst)
  (define (bind2list filter bind)
    (if (null? bind)
        ()
        (cons (filter (car bind))
              (bind2list filter (cdr bind)))))
  (define (make-lambda bind body)
    (cons 'lambda (cons (bind2list car bind) body)))
  (if (symbol? fst)
      (list (list 'lambda ()
                  (list 'define fst (make-lambda (car lst) (cdr lst)))
                  (cons fst (bind2list (lambda (x) (car (cdr x))) (car lst)))))
      (cons (make-lambda fst lst) (bind2list (lambda (x) (car (cdr x))) fst))))

; なんかおかしい。let*の本体ってBodyじゃないの？これじゃExp*でしかないよ？
(define-macro (let* vars . body)
  (define (let*-expander vars body)
    (if (null? vars)
        (cons 'begin body)
        (list 'let (list (car vars)) (let*-expander (cdr vars) body))))
  (let*-expander vars body))

(define-macro (letrec binding . body)
  (define (bind2define bind body)
    (if (null? bind)
        body
        ((lambda (x) (cons (list 'define (car x) (car (cdr x)))
                           (bind2define (cdr bind) body))) (car bind))))
  (list (cons 'lambda (cons () (bind2define binding body)))))

(define-macro (cond . body)
  ...)

(define-macro (and . body)
  (define (expand t rest)
    (if (null? rest)
        t
        (list 'if
                t
                (expand (car rest) (cdr rest))
                #f)))
  (if (null? body)
      #t
      (expand (car body) (cdr body))))

(define-macro (or . body)
  (define (expand body)
    (if (null? body)
        #f
        (let ((x (gensym)))
          (list (list 'lambda (list x)
                      (list 'if x x
                            (expand (cdr body)))) (car body)))))
  (expand body))