# Classe para acessar a API do via CEP
class CepService
    URI = "https://viacep.com.br/ws/"

    def initialize(cep)
        @cep = cep
    end

    def get_address
        response = ::HTTParty.get("#{URI}#{@cep}/json")
        response.parsed_response
    end
end
