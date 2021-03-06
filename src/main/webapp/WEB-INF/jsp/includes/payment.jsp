<link href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>

<!-- Modal -->
<div class="modal fade bd-example-modal-sm" id="replenish" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalCenterTitle">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><fmt:message key="balance.paymentInfo"/>:</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/payment" method="post">
                    <div class="input-wrapper">
                        <input class="form-control input-with-icon" type="number" placeholder="<fmt:message key="balance.sum"/>" name="sum">
                        <label for="card" class="fa fa-dollar input-icon"></label>
                    </div>
                    <hr>
                    <div class="input-wrapper">
                        <input class="form-control input-with-icon" placeholder="<fmt:message key="balance.card"/>" name="card" id="card">
                        <label for="card" class="fa fa-credit-card input-icon"></label>
                    </div>
                    <br>
                    <div class="form-row">
                        <div class="col">
                            <div class="input-wrapper">
                                <input class="form-control input-with-icon" placeholder="MM / YY" id="date">
                                <label for="date" class="fa fa-calendar-o input-icon"></label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-wrapper">
                                <input class="form-control input-with-icon" placeholder="CVC" id="cvc">
                                <label for="cvc" class="fa fa-lock input-icon"></label>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="modal-footer justify-content-center">
                        <button type="submit" class="btn btn-primary"><fmt:message key="orders.pay"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade bd-example-modal-sm" id="withdraw" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalCenterTitle">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><fmt:message key="balance.paymentInfo"/>:</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/payment/withdraw" method="post">
                    <div class="input-wrapper">
                        <input class="form-control input-with-icon" type="number" placeholder="<fmt:message key="balance.sum"/>" name="sum" id="sum">
                        <label for="sum" class="fa fa-dollar input-icon"></label>
                    </div>
                    <hr>
                    <div class="input-wrapper">
                        <input class="form-control input-with-icon" placeholder="<fmt:message key="balance.card"/>" name="card" id="cardW">
                        <label for="card" class="fa fa-credit-card input-icon"></label>
                    </div>
                    <hr>
                    <div class="modal-footer justify-content-center">
                        <button type="submit" class="btn btn-primary"><fmt:message key="balance.withdraw"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style type="text/css">
    .card-deck{
        margin-top: 10px;
        margin-left: auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        grid-gap: .5rem;
    }

    .input-icon {
        position: absolute;
        left: 10px;
        top: calc(50% - 0.5em); /* Keep icon in center of input, regardless of the input height */
    }

    .input-with-icon {
        padding-left: 30px;
    }

    .input-wrapper {
        position: relative;
    }
    *{
        margin: 0;
        padding: 0;
    }
    .rate {
        float: left;
        height: 46px;
        padding: 0 10px;
    }
    .rate:not(:checked) > input {
        position:absolute;
        top:-9999px;
    }
    .rate:not(:checked) > label {
        float:right;
        width:1em;
        overflow:hidden;
        white-space:nowrap;
        cursor:pointer;
        font-size:30px;
        color:#ccc;
    }
    .rate:not(:checked) > label:before {
        content: '★ ';
    }
    .rate > input:checked ~ label {
        color: #ffc700;
    }
    .rate:not(:checked) > label:hover,
    .rate:not(:checked) > label:hover ~ label {
        color: #deb217;
    }
    .rate > input:checked + label:hover,
    .rate > input:checked + label:hover ~ label,
    .rate > input:checked ~ label:hover,
    .rate > input:checked ~ label:hover ~ label,
    .rate > label:hover ~ input:checked ~ label {
        color: #c59b08;
    }
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.js"></script>

<script>
    $('#card').mask("9999 9999 9999 9999");
    $('#cardW').mask("9999 9999 9999 9999");
    $('#date').mask("99 / 99");
    $('#cvc').mask("999");
</script>